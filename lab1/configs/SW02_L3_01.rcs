/system identity set name=SW02_L3_01

/user set 0 name=kate password=123

/ip address
add address=172.20.20.31/24 interface=eth1

/interface bridge
add name=bridge1 vlan-filtering=yes

/interface bridge port
add bridge=bridge1 interface=eth1  
add bridge=bridge1 interface=eth2  

/interface bridge vlan
add bridge=bridge1 tagged=eth1 vlan-ids=10
add bridge=bridge1 untagged=eth2 vlan-ids=10
