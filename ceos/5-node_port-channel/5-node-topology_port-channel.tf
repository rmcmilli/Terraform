# Configure the Docker provider
provider "docker" {
  #    host = "tcp://127.0.0.1:2376"
  host = "unix:///var/run/docker.sock"
}

# Create single ceos containter
resource "docker_container" "spine-1" {
  image = "ceos:latest"
  name  = "spine-1"
  #hostname = "ceos_test"
  attach     = "false"
  env        = ["container=docker", "CEOS=1", "EOS_PLATFORM=ceoslab", "SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "ETBA=1", "INTFTYPE=eth", "MGMT_INTF=eth0"]
  command    = ["/sbin/init", "systemd.setenv=INTFTYPE=eth", "systemd.setenv=ETBA=1", "systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "systemd.setenv=CEOS=1", "systemd.setenv=EOS_PLATFORM=ceoslab", "systemd.setenv=container=docker", "systemd.setenv=MGMT_INTF=eth0"]
  privileged = "true"
  start      = "true"
  networks_advanced {
    name = docker_network.eth0.name
    ipv4_address = "10.250.254.1"
  }
  networks_advanced {
    name = docker_network.eth1.name
  }
  networks_advanced {
    name = docker_network.eth2.name
  }
  networks_advanced {
    name = docker_network.eth3.name
  }
  networks_advanced {
    name = docker_network.eth4.name
  }
  networks_advanced {
    name = docker_network.eth5.name
  }
  networks_advanced {
    name = docker_network.eth6.name
  }
  ports {
    internal = 22
    external = 22
  }
}
resource "docker_container" "spine-2" {
  image = "ceos:latest"
  name  = "spine-2"
  #hostname = "ceos_test"
  attach     = "false"
  env        = ["container=docker", "CEOS=1", "EOS_PLATFORM=ceoslab", "SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "ETBA=1", "INTFTYPE=eth", "MGMT_INTF=eth0"]
  command    = ["/sbin/init", "systemd.setenv=INTFTYPE=eth", "systemd.setenv=ETBA=1", "systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "systemd.setenv=CEOS=1", "systemd.setenv=EOS_PLATFORM=ceoslab", "systemd.setenv=container=docker", "systemd.setenv=MGMT_INTF=eth0"]
  privileged = "true"
  start      = "true"
  networks_advanced {
    name = docker_network.eth0.name
    ipv4_address = "10.250.254.2"
  }
  networks_advanced {
    name = docker_network.eth7.name
  }
  networks_advanced {
    name = docker_network.eth8.name
  }
  networks_advanced {
    name = docker_network.eth9.name
  }
  ports {
    internal = 22
    external = 22
  }
}
resource "docker_container" "leaf-1" {
  image = "ceos:latest"
  name  = "leaf-1"
  #hostname = "ceos_test"
  attach     = "false"
  env        = ["container=docker", "CEOS=1", "EOS_PLATFORM=ceoslab", "SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "ETBA=1", "INTFTYPE=eth", "MGMT_INTF=eth0"]
  command    = ["/sbin/init", "systemd.setenv=INTFTYPE=eth", "systemd.setenv=ETBA=1", "systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "systemd.setenv=CEOS=1", "systemd.setenv=EOS_PLATFORM=ceoslab", "systemd.setenv=container=docker", "systemd.setenv=MGMT_INTF=eth0"]
  privileged = "true"
  start      = "true"
  networks_advanced {
    name = docker_network.eth0.name
    ipv4_address = "10.250.254.3"
  }
  networks_advanced {
    name = docker_network.eth1.name
  }  
  networks_advanced {
    name = docker_network.eth2.name
  }
  networks_advanced {
    name = docker_network.eth7.name
  }
  ports {
    internal = 22
    external = 22
  }
}
resource "docker_container" "leaf-2" {
  image = "ceos:latest"
  name  = "leaf-2"
  #hostname = "ceos_test"
  attach     = "false"
  env        = ["container=docker", "CEOS=1", "EOS_PLATFORM=ceoslab", "SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "ETBA=1", "INTFTYPE=eth", "MGMT_INTF=eth0"]
  command    = ["/sbin/init", "systemd.setenv=INTFTYPE=eth", "systemd.setenv=ETBA=1", "systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "systemd.setenv=CEOS=1", "systemd.setenv=EOS_PLATFORM=ceoslab", "systemd.setenv=container=docker", "systemd.setenv=MGMT_INTF=eth0"]
  privileged = "true"
  start      = "true"
  networks_advanced {
    name = docker_network.eth0.name
    ipv4_address = "10.250.254.4"
  }
  networks_advanced {
    name = docker_network.eth3.name
  }
    networks_advanced {
    name = docker_network.eth4.name
  }
  networks_advanced {
    name = docker_network.eth8.name
  }
  ports {
    internal = 22
    external = 22
  }
}
resource "docker_container" "leaf-3" {
  image = "ceos:latest"
  name  = "leaf-3"
  #hostname = "ceos_test"
  attach     = "false"
  env        = ["container=docker", "CEOS=1", "EOS_PLATFORM=ceoslab", "SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "ETBA=1", "INTFTYPE=eth", "MGMT_INTF=eth0"]
  command    = ["/sbin/init", "systemd.setenv=INTFTYPE=eth", "systemd.setenv=ETBA=1", "systemd.setenv=SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1", "systemd.setenv=CEOS=1", "systemd.setenv=EOS_PLATFORM=ceoslab", "systemd.setenv=container=docker", "systemd.setenv=MGMT_INTF=eth0"]
  privileged = "true"
  start      = "true"
  networks_advanced {
    name = docker_network.eth0.name
    ipv4_address = "10.250.254.5"
  }
  networks_advanced {
    name = docker_network.eth5.name
  }
  networks_advanced {
    name = docker_network.eth6.name
  }
  networks_advanced {
    name = docker_network.eth9.name
  }
  ports {
    internal = 22
    external = 22
  }
}
resource "docker_network" "eth0" {
  name = "eth0"
  ipam_config {
    subnet = "10.250.254.0/24"
  }
}
resource "docker_network" "eth1" {
  name = "eth1"
}
resource "docker_network" "eth2" {
  name = "eth2"
  }
resource "docker_network" "eth3" {
  name = "eth3"
}
resource "docker_network" "eth4" {
  name = "eth4"
  }
resource "docker_network" "eth5" {
  name = "eth5"
  }
resource "docker_network" "eth6" {
  name = "eth6"
  }
resource "docker_network" "eth7" {
  name = "eth7"
  }
resource "docker_network" "eth8" {
  name = "eth8"
  }
resource "docker_network" "eth9" {
  name = "eth9"
  }
resource "docker_network" "eth10" {
  name = "eth10"
  }
resource "docker_network" "eth11" {
  name = "eth11"
  }
resource "docker_network" "eth12" {
  name = "eth12"
  }
resource "docker_network" "eth13" {
  name = "eth13"
  }