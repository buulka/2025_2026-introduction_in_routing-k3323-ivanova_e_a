/system identity
set name=SW01

/user
set 0 name=kate password=123

/interface bridge
add name=bridge1 vlan-filtering=yes

/interface vlan
add name=vlan10 vlan-id=10 interface=bridge1
add name=vlan20 vlan-id=20 interface=bridge1

/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4

/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether2,ether3 vlan-ids=10
add bridge=bridge1 tagged=bridge1,ether2,ether4 vlan-ids=20

/ip address
add address=192.168.10.2/24 interface=vlan10
add address=192.168.20.2/24 interface=vlan20

/ip pool
add name=dhcp-pool10 ranges=192.168.10.10-192.168.10.254
add name=dhcp-pool20 ranges=192.168.20.10-192.168.20.254

/ip dhcp-server
add address-pool=dhcp-pool10 disabled=no interface=vlan10 name=dhcp-server10
add address-pool=dhcp-pool20 disabled=no interface=vlan20 name=dhcp-server20

/ip dhcp-server network
add address=192.168.10.0/24 gateway=192.168.10.2
add address=192.168.20.0/24 gateway=192.168.20.2


