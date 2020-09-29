#!/bin/bash
ip addr add 10.0.10.2/24 dev eth0
ip route delete default
ip route add default via 10.0.10.1 dev eth0