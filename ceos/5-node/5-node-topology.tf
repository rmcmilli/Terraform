# Configure the Docker provider
provider "docker" {
    host = "tcp://127.0.0.1:2376"
}

# Create single ceos containter
resource "docker_container" "spine-1" {
  image = "ceos:latest"
  name = "spine-1"
  #hostname = "ceos_test"
  attach = "false"
  env = ["container=docker","CEOS=1","EOS_PLATFORM=ceoslab","SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1","ETBA=1","INTFTYPE=eth"]
  command = ["/sbin/init"]
  privileged = "true"
  start = "true"
  networks_advanced {
      name = "eth0"
  } 
  networks_advanced {
      name = "eth1"
  }
  networks_advanced {
      name = "eth2"
  }
  networks_advanced {
      name = "eth3"
  }
}
resource "docker_container" "spine-2" {
  image = "ceos:latest"
  name = "spine-2"
  #hostname = "ceos_test"
  attach = "false"
  env = ["container=docker","CEOS=1","EOS_PLATFORM=ceoslab","SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1","ETBA=1","INTFTYPE=eth"]
  command = ["/sbin/init"]
  privileged = "true"
  start = "true"
  networks_advanced {
      name = "eth0"
  } 
  networks_advanced {
      name = "eth4"
  }
  networks_advanced {
      name = "eth5"
  }
  networks_advanced {
      name = "eth6"
  }
}
resource "docker_container" "leaf-1" {
  image = "ceos:latest"
  name = "leaf-1"
  #hostname = "ceos_test"
  attach = "false"
  env = ["container=docker","CEOS=1","EOS_PLATFORM=ceoslab","SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1","ETBA=1","INTFTYPE=eth"]
  command = ["/sbin/init"]
  privileged = "true"
  start = "true"
  networks_advanced {
      name = "eth0"
  } 
  networks_advanced {
      name = "eth1"
  }
  networks_advanced {
      name = "eth4"
  }
}
resource "docker_container" "leaf-2" {
  image = "ceos:latest"
  name = "leaf-2"
  #hostname = "ceos_test"
  attach = "false"
  env = ["container=docker","CEOS=1","EOS_PLATFORM=ceoslab","SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1","ETBA=1","INTFTYPE=eth"]
  command = ["/sbin/init"]
  privileged = "true"
  start = "true"
  networks_advanced {
      name = "eth0"
  } 
  networks_advanced {
      name = "eth2"
  }
  networks_advanced {
      name = "eth5"
  }
}
resource "docker_container" "leaf-3" {
  image = "ceos:latest"
  name = "leaf-3"
  #hostname = "ceos_test"
  attach = "false"
  env = ["container=docker","CEOS=1","EOS_PLATFORM=ceoslab","SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1","ETBA=1","INTFTYPE=eth"]
  command = ["/sbin/init"]
  privileged = "true"
  start = "true"
  networks_advanced {
      name = "eth0"
  } 
  networks_advanced {
      name = "eth3"
  }
  networks_advanced {
      name = "eth6"
  }
}
resource "docker_network" "eth0" {
  name = "eth0"
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
}resource "docker_network" "eth9" {
    name = "eth9"
}resource "docker_network" "eth10" {
    name = "eth10"
}