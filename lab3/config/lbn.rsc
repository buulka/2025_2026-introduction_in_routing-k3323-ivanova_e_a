/system identity
set name=LBN

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge
add name=lo

/ip address
add address=1.1.1.15/32 interface=lo
add address=10.0.0.18/30 interface=ether2 comment="to MSK"
add address=10.0.0.21/30 interface=ether3 comment="to NY"
add address=10.0.0.26/30 interface=ether4 comment="to HKI"

/routing ospf instance
set [find default=yes] router-id=1.1.1.15

/routing ospf network
add network=1.1.1.15/32 area=backbone
add network=10.0.0.16/30 area=backbone
add network=10.0.0.20/30 area=backbone
add network=10.0.0.24/30 area=backbone

/mpls interface
add interface=ether2
add interface=ether3
add interface=ether4

/mpls ldp
set enabled=yes lsr-id=1.1.1.15 transport-address=1.1.1.15

/mpls ldp interface
add interface=ether2
add interface=ether3
add interface=ether4