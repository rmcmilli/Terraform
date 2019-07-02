# Configure the Docker provider
#provider "docker" {
#    host = "tcp://127.0.0.1:2376"
#}

# Create single ceos containter
resource "docker_container" "ceos_test" {
  image = "ceos:latest"
  name = "ceos_test"
  #hostname = "ceos_test"
  attach = "false"
  env = ["container=docker","CEOS=1","EOS_PLATFORM=ceoslab","SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1","ETBA=1","INTFTYPE=eth"]
  command = ["/sbin/init"]
  privileged = "true"
  start = "true"
  networks_advanced {
      name = "net1"
  } 
  networks_advanced {
      name = "net2"
  }
  networks_advanced {
      name = "net3"
  }
  networks_advanced {
      name = "net4"
  }
}

resource "docker_network" "net1" {
  name = "net1"
}

resource "docker_network" "net2" {
  name = "net2"
}
resource "docker_network" "net3" {
  name = "net3"
}
resource "docker_network" "net4" {
    name = "net4"
}

