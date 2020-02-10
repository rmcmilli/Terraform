# Configure the Docker provider
provider "docker" {
    #host = "tcp://127.0.0.1:2376"
    host = "unix:///var/run/docker.sock"
}

# Create single ceos containter
resource "docker_container" "spine-1" {
  image = "ceos:latest"
  name = "spine-1"
  #hostname = "spine-1"
  attach = "false"
  env = ["container=docker","CEOS=1","EOS_PLATFORM=ceoslab","SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1","ETBA=1","INTFTYPE=eth"]
  command = ["/sbin/init"]
  privileged = "true"
  start = "true"
  restart = "always"
  networks_advanced {
      name = docker_network.eth0.name
  } 
  networks_advanced {
      name = docker_network.eth1.name
  }
  networks_advanced {
      #name = "eth2"
      name = docker_network.eth2.name
  }
  networks_advanced {
      name = docker_network.eth3.name
  }
  upload {
      content = file("${path.module}/configs/Spine-1.conf")
      file = "/mnt/flash/startup-config"
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
  restart = "always"
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
  upload {
      content = file("${path.module}/configs/Spine-2.conf")
      file = "/mnt/flash/startup-config"
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
  restart = "always"
  networks_advanced {
      name = docker_network.eth0.name
  } 
  networks_advanced {
      name = docker_network.eth1.name
  }
  networks_advanced {
      name = docker_network.eth4.name
  }
  networks_advanced{
      name = docker_network.eth7.name
      #ipv4_address = "10.254.0.5"
      ipv4_address = "192.168.20.254"
  }
  networks_advanced{
      name = docker_network.eth8.name
      ipv4_address = "10.254.0.2"
  }
  /*networks_advanced{
      name = "eth9"
  }*/
  upload {
      content = file("${path.module}/configs/Leaf-1.conf")
      file = "/mnt/flash/startup-config"
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
  restart = "always"
  networks_advanced {
      name = docker_network.eth0.name
  } 
  networks_advanced {
      name = docker_network.eth2.name
  }
  networks_advanced {
      name = docker_network.eth5.name
  }
  #networks_advanced {
   #   name = "docker_network.th10.name
  #}
  #networks_advanced {
   #   name = "docker_network.th11.name
  #}
  #networks_advanced {
    #  name = "docker_network.th12.name
  #}
  upload {
      content = file("${path.module}/configs/Leaf-2.conf")
      file = "/mnt/flash/startup-config"
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
  restart = "always"
  networks_advanced {
      name = docker_network.eth0.name
  } 
  networks_advanced {
      name = docker_network.eth3.name
  }
  networks_advanced {
      name = docker_network.eth6.name
  }
  networks_advanced {
      name = docker_network.eth13.name
  }/*
  networks_advanced {
      name = "docker_network.eth14.name
  }
  networks_advanced {
      name = "docker_network.eth15.name
  }*/
}
resource "docker_container" "host1_leaf1"{
    #image = "ubuntu:18.04"
    # The image below is alpine-based with installed network tools
    image = "praqma/network-multitool:latest"
    name  = "host1_leaf1"
    hostname = "host1_leaf1"
    attach = "false"
    logs = "false"
#    command = ["sleep", "600"]
    command = ["tail", "-f", "/dev/null"]
#    entrypoint = ["bash","ip route delete default via 192.168.20.1 dev eth0 && ip route add default via 192.168.20.254 dev eth0"]
    start = "true"
    restart = "always"
    networks_advanced {
        name = docker_network.eth7.name
        #ipv4_address = "10.254.0.250"
        ipv4_address = "192.168.20.250"
    }
    capabilities {
        add = ["NET_ADMIN"]
    }
}
resource "docker_network" "eth0" {
  name = "eth0"
  driver = "macvlan"
  options = {
      macvlan_mode = "bridge"
      }
}

resource "docker_network" "eth1" {
  name = "eth1"
  driver = "macvlan"
  options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth2" {
  name = "eth2"
  driver = "macvlan"
  options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth3" {
    name = "eth3"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth4" {
    name = "eth4"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth5" {
    name = "eth5"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth6" {
    name = "eth6"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth7" {
    name = "eth7"
    #driver = "macvlan"
    ipam_config {
        #subnet = "10.254.0.0/24"
        subnet = "192.168.20.0/24"
        gateway = "192.168.20.1"
    }
    /*options = {
      macvlan_mode = "bridge"
      parent = "enp0s31f6"
      }*/
}
resource "docker_network" "eth8" {
    name = "eth8"
    driver = "bridge"
    /*options = {
      macvlan_mode = "bridge"
      parent = "eth0"
      }*/
    ipam_config {
        subnet = "10.254.0.0/24"
        gateway = "10.254.0.1"
        #subnet = "192.168.20.0/24"
    }  
}
resource "docker_network" "eth9" {
    name = "eth9"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth10" {
    name = "eth10"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth11" {
    name = "eth11"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth12" {
    name = "eth12"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth13" {
    name = "eth13"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth14" {
    name = "eth14"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth15" {
    name = "eth15"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth16" {
    name = "eth16"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth17" {
    name = "eth17"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
resource "docker_network" "eth18" {
    name = "eth18"
    driver = "macvlan"
    options = {
      macvlan_mode = "bridge"
      }
}
/*
output "whatever_name"{
    value = docker_network.eth2.scope
}
output "whatever_name_2"{
    value = docker_network.eth2.id
}
output "whatever_name_3"{
    value = docker_network.eth2.name
}*/