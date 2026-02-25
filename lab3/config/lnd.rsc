/system identity
set name=LND

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge add name=lo protocol-mode=none
/ip address add address=10.255.0.2/32 interface=lo comment=loopback

/ip address
add address=10.0.0.2/30 interface=ether2
add address=10.0.0.5/30 interface=ether3

/routing ospf instance set [find default=yes] router-id=10.255.0.2
/routing ospf network
add network=10.255.0.2/32 area=backbone
add network=10.0.0.0/30 area=backbone
add network=10.0.0.4/30 area=backbone

/mpls ldp set enabled=yes lsr-id=10.255.0.2 transport-address=10.255.0.2
/mpls ldp interface
add interface=ether2
add interface=ether3