/system identity 
set name=SW02_L3_01

/user 
add name=kate password=123 group=full

/interface bridge
add name=bridge1

/interface vlan
add name=vlan20 vlan-id=20 interface=bridge1

/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3 pvid=10

/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether2 untagged=ether3 vlan-ids=10

/ip address
add address=192.168.20.3/24 interface=vlan10


