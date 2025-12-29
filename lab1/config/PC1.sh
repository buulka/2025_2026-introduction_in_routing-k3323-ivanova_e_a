#!/bin/sh

ip link add link eth1 name vlan10 type vlan id 10
ip link set vlan10 up

udhcpc -i vlan10

ip route add default via 192.168.10.1 dev vlan10

ip addr
ping -c 2 192.168.10.1
