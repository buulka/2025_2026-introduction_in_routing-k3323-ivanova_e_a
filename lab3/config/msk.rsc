/system identity
set name=MSK

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge add name=lo protocol-mode=none
/ip address add address=10.255.0.5/32 interface=lo comment=loopback

/ip address
add address=10.0.0.14/30 interface=ether2
add address=10.0.0.17/30 interface=ether3

# OSPF
/routing ospf instance set [find default=yes] router-id=10.255.0.5
/routing ospf network
add network=10.255.0.5/32 area=backbone
add network=10.0.0.12/30 area=backbone
add network=10.0.0.16/30 area=backbone

/mpls ldp set enabled=yes lsr-id=10.255.0.5 transport-address=10.255.0.5
/mpls ldp interface
add interface=ether2
add interface=ether3