#!/bin/sh
ip route del default via 172.14.14.1 dev eth0
# udhcpc -i eth1