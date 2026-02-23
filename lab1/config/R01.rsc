/system identity
set name=R01

/user
add name=kate password=123 group=full

/interface vlan
add name=vlan10 vlan-id=10 interface=ether2
add name=vlan20 vlan-id=20 interface=ether2

/ip address
add address=192.168.10.1/24 interface=vlan10
add address=192.168.20.1/24 interface=vlan20

/ip pool
add name=pool-vlan10 ranges=192.168.10.100-192.168.10.200
add name=pool-vlan20 ranges=192.168.20.100-192.168.20.200

/ip dhcp-server
add address-pool=pool-vlan10 interface=vlan10 name=dhcp-vlan10
add address-pool=pool-vlan20 interface=vlan20 name=dhcp-vlan20

/ip dhcp-server network
add address=192.168.10.0/24 gateway=192.168.10.1
add address=192.168.20.0/24 gateway=192.168.20.1






