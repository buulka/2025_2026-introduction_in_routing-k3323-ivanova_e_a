/system identity
set name=MSK

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge
add name=lo

/ip address
add address=10.0.0.14/30 interface=ether2 comment="to SPB"
add address=10.0.0.17/30 interface=ether3 comment="to LBN"

/routing ospf instance
set [find default=yes] router-id=1.1.1.16

/routing ospf network
add network=1.1.1.16/32 area=backbone
add network=10.0.0.12/30 area=backbone
add network=10.0.0.16/30 area=backbone

/mpls interface
add interface=ether2
add interface=ether3

/mpls ldp
set enabled=yes lsr-id=1.1.1.16 transport-address=1.1.1.16

/mpls ldp interface
add interface=ether2
add interface=ether3