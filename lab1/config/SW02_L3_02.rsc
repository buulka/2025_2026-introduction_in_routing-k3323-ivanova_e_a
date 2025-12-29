/system identity
set name=SW01

/user
set 0 name=kate password=123

/interface bridge
add name=bridge1 vlan-filtering=yes

/interface vlan
add name=vlan10 vlan-id=10 interface=bridge1

/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3

/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether2 untagged=ether3 vlan-ids=10

/ip address
add address=192.168.10.3/24 interface=vlan10
