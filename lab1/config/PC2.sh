#!/bin/sh

ip link add link eth1 name vlan20 type vlan id 20
ip link set vlan20 up

udhcpc -i vlan20

ip route add default via 192.168.20.1 dev vlan20

ip addr
ping -c 2 192.168.20.1
