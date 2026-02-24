/system identity
set name=LND

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge
add name=lo

/ip address
add address=1.1.1.12/32 interface=lo
add address=10.0.0.2/30 interface=ether2 comment="to NY"
add address=10.0.0.5/30 interface=ether3 comment="to HKI"

/routing ospf instance
set [find default=yes] router-id=1.1.1.12

/routing ospf network
add network=1.1.1.12/32 area=backbone
add network=10.0.0.0/30 area=backbone
add network=10.0.0.4/30 area=backbone

/mpls interface
add interface=ether2
add interface=ether3

/mpls ldp
set enabled=yes lsr-id=1.1.1.12 transport-address=1.1.1.12

/mpls ldp interface
add interface=ether2
add interface=ether3