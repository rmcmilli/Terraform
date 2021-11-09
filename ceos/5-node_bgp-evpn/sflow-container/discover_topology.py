#/usr/bin/python 
'''
Copyright (c) 2015, Arista Networks, Inc. All rights reserved.
 
Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, 
   this list of conditions and the following disclaimer. 

 * Redistributions in binary form must reproduce the above copyright notice, 
   this list of conditions and the following disclaimer in the documentation 
   and/or other materials provided with the distribution. 

 * Neither the name of Arista Networks nor the names of its contributors 
   may be used to endorse or promote products derived from this software 
   without specific prior written permission.
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL ARISTA NETWORKS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
'''

# v0.5 - initial version of the script to discover network topology using
# Arista eAPI and generate output in json format recognized by sFlow-RT.

from jsonrpclib import Server 
import json 
from pprint import pprint

# define switch in your topology, eapi transport protocol (http or https),
# eapi username and password
switch_list = ['10.250.254.2','10.250.254.3','10.250.254.4','10.250.254.5','10.250.254.6','10.250.254.7']
eapi_transport = 'https'
eapi_username = 'admin'
eapi_password = 'password1!'

debug = False

# internal variables used by the script
allports = {}
allswitches = {}
allneighbors = []
alllinks = {}

# method to populate allswitches and allports - called only from processNeighbor()
def addPort(switchname, switchIP, portname, ifindex):
 id = switchname + '>' + portname
 prt = allports.setdefault(id, { "portname": portname, "linked": False })
 if ifindex is not None:
  prt["ifindex"] = ifindex
 sw = allswitches.setdefault(switchname, { "name": switchname, "agent": switchIP, "ports": {} });
 if switchIP is not None:
  sw["agent"] = switchIP
 sw["ports"][portname] = prt

# method to collect neighbor records - called with each LLDP neighbor 
# entry as they are discovered
def processNeighbor(localname,localip,localport,localifindex,remotename,remoteport):
 addPort(localname, localip, localport,localifindex);
 addPort(remotename, None, remoteport, None);
 allneighbors.append({ "localname": localname, "localport": localport,
         "remotename": remotename, "remoteport": remoteport });

# method to remove agents that we did not discover properly, or
# that we did not intend to include in the topology.  (If we
# assigned an agent field to the switch then we assume it should stay.)
def pruneAgents():
 for nm,sw in allswitches.items():
  #if not "agent" in sw:
  if sw['agent'] == '0.0.0.0' or not sw['agent']:
   del allswitches[nm]

# method to test for a new link - called only from findLinks()
def testLink(nbor,linkno):
 swname1 = nbor["localname"]
 swname2 = nbor["remotename"]
 # one of the switches might have been pruned out
 if swname1 not in allswitches or swname2 not in allswitches:
  return False
 sw1 = allswitches[swname1]
 sw2 = allswitches[swname2]
 pname1 = nbor["localport"]
 pname2 = nbor["remoteport"]
 port1 = sw1["ports"][pname1];
 port2 = sw2["ports"][pname2];
 if not port1["linked"] and not port2["linked"]:
  # add new link
  linkid = "link" + str(linkno)
  port1["linked"] = True;
  port2["linked"] = True;
  alllinks[linkid] = {
   "node1": nbor["localname"],
   "port1": nbor["localport"],
   "node2": nbor["remotename"],
   "port2": nbor["remoteport"]
   }
  return True
 return False

# method to find unique links - call at the end once all the LLDP records have
# been processed from all the switches
def findLinks():
 linkcount = 0
 for nbor in allneighbors:
  if testLink(nbor, linkcount+1):
   linkcount += 1

# method to dump topology in json format recognized by sFlow-RT
def dumpTopology():
 topology = { "nodes": allswitches, "links": alllinks }
 print(json.dumps(topology, indent=4))

# method to get LLDP neighbors of each switch - calls processNeighbor() for each LLDP neighbor found
def getLldpNeighbors(switch_name):
 try:
  switch = Server('%s://%s:%s@%s/command-api' % (eapi_transport, eapi_username, eapi_password, switch_name))

  # Get LLDP neighbors
  commands = ["enable", "show lldp neighbors"]
  response = switch.runCmds(1, commands, 'json')
  neighbors = response[1]['lldpNeighbors']

  # Get local hostname
  commands = ["enable", "show hostname"]
  response = switch.runCmds(1, commands, 'json')
  hostname = response[1]['hostname']

  # Get SNMP ifIndexes
  commands = ["enable", "show snmp mib ifmib ifindex"]
  response = switch.runCmds(1, commands, 'json')
  interfaceIndexes = response[1]['ifIndex']

  # Get sFlow agent source address
  commands = ["enable", "show sflow"]
  response = switch.runCmds(1, commands, 'json')
  sflowAddress = response[1]['ipv4Sources'][0]['ipv4Address']
  
  # Create 2D array lldp_neighbors where each line has following entries 
  # , , , 
  lldp_neighbors = []
  for neighbor in neighbors:
   lldp_neighbors.append([neighbor['neighborDevice'].split('.')[0], 
        neighbor['port'], neighbor['neighborPort'], interfaceIndexes[neighbor['port']]])
  
  if (debug): 
   pprint(lldp_neighbors)


  # collect switches, ports and neighbor-relationships
  for row in lldp_neighbors:
   processNeighbor(hostname, 
    sflowAddress,
    row[1], # localport
    row[3], # localifindex
    row[0], # remotename
    row[2]) # remoteport

  # Print list of LLDP neighbors in human friendly format:
  #  neighbor, , connected to local  with remote 
  if debug:
   print "Switch %s has following %d neighbors:" % (hostname[1], len(neighbors))
   for i, neighbor in enumerate(lldp_neighbors):
    print "#%d neighbor, %s, connected to local %s with remote %s" % (i+1, neighbor[0], neighbor[1], neighbor[2])

 except:
  print 'Exception while connecting to %s' % switch_name
  return []


for switch in switch_list:
 getLldpNeighbors(switch)

pruneAgents()
findLinks()
dumpTopology()