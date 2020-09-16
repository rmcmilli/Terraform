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
  }
  networks_advanced {
    name = docker_network.eth1.name
  }  
  networks_advanced {
    name = docker_network.eth4.name
  }
  /*networks_advanced {
    name = docker_network.eth7.name
  }*/
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
  }
  networks_advanced {
    name = docker_network.eth2.name
  }
    networks_advanced {
    name = docker_network.eth5.name
  }
  /*networks_advanced {
    name = docker_network.eth8.name
  }*/
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
  }
  networks_advanced {
    name = docker_network.eth3.name
  }
  networks_advanced {
    name = docker_network.eth6.name
  }
/*  networks_advanced {
    name = docker_network.eth9.name
  }*/
}
resource "docker_network" "eth0" {
  name = "eth0"
}
resource "docker_network" "eth1" {
  name = "eth1"
  driver = "macvlan"
}
resource "docker_network" "eth2" {
  name = "eth2"
  driver = "macvlan"
}
resource "docker_network" "eth3" {
  name = "eth3"
  driver = "macvlan"
}
resource "docker_network" "eth4" {
  name = "eth4"
  driver = "macvlan"
}
resource "docker_network" "eth5" {
  name = "eth5"
  driver = "macvlan"
}
resource "docker_network" "eth6" {
  name = "eth6"
  driver = "macvlan"
}
resource "docker_network" "eth7" {
  name = "eth7"
  driver = "macvlan"
}
resource "docker_network" "eth8" {
  name = "eth8"
  driver = "macvlan"
}
resource "docker_network" "eth9" {
  name = "eth9"
  driver = "macvlan"
}
resource "docker_network" "eth10" {
  name = "eth10"
  driver = "macvlan"
}
resource "docker_network" "eth11" {
  name = "eth11"
  driver = "macvlan"
}
resource "docker_network" "eth12" {
  name = "eth12"
  driver = "macvlan"
}
resource "docker_network" "eth13" {
  name = "eth13"
  driver = "macvlan"
}