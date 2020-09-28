# Configure the Docker provider
provider "docker" {
  #    host = "tcp://127.0.0.1:2376"
  host = "unix:///var/run/docker.sock"
}

# Create single ceos containter
resource "docker_container" "spine-1" {
  image = docker_image.ceos.latest
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
  ports {
    internal = 443
    external = 8001
  }
  provisioner "local-exec" {
    command = "ansible-playbook -e 'switch_name=spine-1' apply-config-mod.yml"
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
  ports {
    internal = 443
    external = 8002
  }
  provisioner "local-exec" {
    command = "ansible-playbook -e 'switch_name=spine-2' apply-config-mod.yml"
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
  networks_advanced {
    name = docker_network.eth10.name
  }
  networks_advanced {
    name = docker_network.eth11.name
  }
  ports {
    internal = 22
    external = 2223
  }
  ports {
    internal = 443
    external = 8003
  }
  provisioner "local-exec" {
    command = "ansible-playbook -e 'switch_name=leaf-1' apply-config-mod.yml"
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
  networks_advanced {
    name = docker_network.eth12.name
  }
  ports {
    internal = 22
    external = 2224
  }
  ports {
    internal = 443
    external = 8004
  }
  provisioner "local-exec" {
    command = "ansible-playbook -e 'switch_name=leaf-2' apply-config-mod.yml"
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
  networks_advanced {
    name = docker_network.eth13.name
  }
  ports {
    internal = 22
    external = 2225
  }
  ports {
    internal = 443
    external = 8005
  }
  provisioner "local-exec" {
    command = "ansible-playbook -e 'switch_name=leaf-3' apply-config-mod.yml"
  }
}
resource "docker_container" "host1_leaf1" {
  #image = "ubuntu:18.04"
  # The image below is alpine-based with installed network tools
  image    = "praqma/network-multitool:latest"
  name     = "host1_leaf1"
  hostname = "host1_leaf1"
  attach   = "false"
  logs     = "false"
  #    command = ["sleep", "600"]
  command = ["tail", "-f", "/dev/null"]
  #    entrypoint = ["bash","ip route delete default via 192.168.20.1 dev eth0 && ip route add default via 192.168.20.254 dev eth0"]
  start   = "true"
  restart = "always"
  networks_advanced {
    name = docker_network.eth10.name
  }
  capabilities {
    add = ["NET_ADMIN"]
  }
}
# Get latest ceos image
resource "docker_image" "ceos" {
  name = "ceos:latest"
  keep_locally = "true"
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