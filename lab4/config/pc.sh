#!/bin/sh
ip route del default via 172.140.24.1 dev eth0
udhcpc -i eth1