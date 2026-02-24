/system identity
set name=HKI

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge
add name=lo

/ip address
add address=10.0.0.6/30 interface=ether2 comment="to LND"
add address=10.0.0.9/30 interface=ether3 comment="to SPB"
add address=10.0.0.25/30 interface=ether4 comment="to LBN"

/routing ospf instance
set [find default=yes] router-id=1.1.1.13

/routing ospf network
add network=1.1.1.13/32 area=backbone
add network=10.0.0.4/30 area=backbone
add network=10.0.0.8/30 area=backbone
add network=10.0.0.24/30 area=backbone

/mpls interface
add interface=ether2
add interface=ether3
add interface=ether4

/mpls ldp
set enabled=yes lsr-id=1.1.1.13 transport-address=1.1.1.13

/mpls ldp interface
add interface=ether2
add interface=ether3
add interface=ether4