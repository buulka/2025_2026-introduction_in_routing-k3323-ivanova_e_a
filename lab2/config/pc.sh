#!/bin/sh

ip route del default via 172.120.12.1 dev eth0
udhcpc -i eth1
