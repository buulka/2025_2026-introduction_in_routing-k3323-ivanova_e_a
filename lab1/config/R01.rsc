/system identity set name=R01

/user set 0 name=kate password=123

/interface vlan
add name=vlan10 interface=eth2 vlan-id=10
add name=vlan20 interface=eth3 vlan-id=20

/ip address
add address=192.168.10.1/24 interface=vlan10
add address=192.168.20.1/24 interface=vlan20

/ip pool
add name=pool-vlan10 ranges 192.168.10.10-192.168.10.100
add name=pool-vlan20 ranges 192.168.20.10-192.168.20.10

/ip dhcp-server
add name=dhcp-vlan10 interface=vlan10 address-pool=pool-vlan10
add name=dhcp-vlan20 interface=vlan20 address-pool=poll-vlan20

/ip dhcp-server enable dhcp-vlan10
/ip dhcp-server enable dhcp-vlan20
