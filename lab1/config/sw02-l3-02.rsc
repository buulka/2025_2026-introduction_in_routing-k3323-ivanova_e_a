/system identity
set name=SW02_L3_02

/user
add name=kate password=123 group=full

/interface bridge
add name=bridge

/interface vlan
add name=vlan20 vlan-id=20 interface=bridge

/interface bridge port
add bridge=bridge interface=ether2
add bridge=bridge interface=ether3 pvid=10

/interface bridge vlan
add bridge=bridge tagged=bridge,ether2 untagged=ether3 vlan-ids=20

/ip address
add address=10.20.0.3/24 interface=vlan20
