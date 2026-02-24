/system identity
set name=NY

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge
add name=lo

/ip address
add address=1.1.1.11/32 interface=lo
add address=10.0.0.1/30 interface=ether2 comment="to LND"
add address=10.0.0.22/30 interface=ether3 comment="to LBN"

/routing ospf instance
set [find default=yes] router-id=1.1.1.11

/routing ospf network
add network=1.1.1.11/32 area=backbone
add network=10.0.0.0/30 area=backbone
add network=10.0.0.20/30 area=backbone

/mpls interface
add interface=ether2
add interface=ether3

/mpls ldp
set enabled=yes lsr-id=1.1.1.11 transport-address=1.1.1.11

/mpls ldp interface
add interface=ether2
add interface=ether3

/interface vpls
add name=vpls-to-spb remote-peer=1.1.1.14 vpls-id=100:1

/interface bridge
add name=br-eompls

/interface bridge port
add bridge=br-eompls interface=ether4
add bridge=br-eompls interface=vpls-to-spb