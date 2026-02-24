#!/bin/sh

ip route del default via 172.13.13.1 dev eth0
udhcpc -i eth1