# Configure the Docker provider
provider "docker" {
  #    host = "tcp://127.0.0.1:2376"
  host = "unix:///var/run/docker.sock"
}

variable "long-id" {
  type = string
  default = "000000000000000"
}
variable "short-id" {
  type = string
  default = "000000000000"
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
    ipv4_address = "10.250.254.2"
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
    external = 2221
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
    ipv4_address = "10.250.254.3"
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
    external = 2222
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
    ipv4_address = "10.250.254.4"
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
    external = 2223
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
    ipv4_address = "10.250.254.5"
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
    external = 2224
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
    ipv4_address = "10.250.254.6"
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
    external = 2225
  }
}
resource "docker_network" "eth0" {
  name = "eth0"
  ipam_config {
    subnet = "10.250.254.0/24"
    gateway = "10.250.254.1"
  }
}
resource "docker_network" "eth1" {
  name = "eth1"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth1.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth2" {
  name = "eth2"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth2.id, 0, 12)}/bridge/group_fwd_mask"
  }
  }
resource "docker_network" "eth3" {
  name = "eth3"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth3.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth4" {
  name = "eth4"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth4.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth5" {
  name = "eth5"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth5.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth6" {
  name = "eth6"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth6.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth7" {
  name = "eth7"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth7.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth8" {
  name = "eth8"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth8.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth9" {
  name = "eth9"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth9.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth10" {
  name = "eth10"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth10.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth11" {
  name = "eth11"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth11.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth12" {
  name = "eth12"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth12.id, 0, 12)}/bridge/group_fwd_mask"
  }
}
resource "docker_network" "eth13" {
  name = "eth13"
  provisioner "local-exec" {
    command = "echo 16384 | sudo tee -a /sys/class/net/br-${substr(docker_network.eth13.id, 0, 12)}/bridge/group_fwd_mask"
  }
}