# Configure the Docker provider
provider "docker" {
    host = "tcp://127.0.0.1:2376"
}

# Create single ceos containter
resource "docker_container" "ceos_test" {
  image = "ceos:latest"
  name = "ceos_test"
  #hostname = "ceos_test"
  attach = "true"
  env = ["container=docker","CEOS=1","EOS_PLATFORM=ceossim","SKIP_ZEROTOUCH_BARRIER_IN_SYSDBINIT=1","ETBA=1","INTFTYPE=eth"]
  command = ["/sbin/init","Cli"]
}