#!/bin/sh
ip addr add 10.0.10.3/24 dev eth0
ip route delete default
ip route add default via 10.0.10.1 dev eth0
#This turns off tcp checksum checking
ethtool --offload eth0 rx off tx off
# reducing mtu
# ip li set mtu 9000 dev eth0
# Create file for testing transfers
head -c 1073741824 </dev/urandom >myfile
#This makes it so the container doesn't stop
tail -f /dev/null