/system identity
set name=NY

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge add name=lo protocol-mode=none
/ip address add address=10.255.0.1/32 interface=lo comment=loopback

/ip address
add address=10.0.0.1/30 interface=ether2
add address=10.0.0.22/30 interface=ether3

/routing ospf instance set [find default=yes] router-id=10.255.0.1
/routing ospf network
add network=10.255.0.1/32 area=backbone
add network=10.0.0.0/30 area=backbone
add network=10.0.0.20/30 area=backbone

/mpls ldp set enabled=yes lsr-id=10.255.0.1 transport-address=10.255.0.1
/mpls ldp interface
add interface=ether2
add interface=ether3

/interface vpls
add name=vpls_to_spb remote-peer=10.255.0.4 vpls-id=100:1 pw-type=raw-ethernet use-control-word=no disabled=no
/interface bridge add name=br_eompls protocol-mode=none
/interface bridge port
add bridge=br_eompls interface=ether4
add bridge=br_eompls interface=vpls_to_spb
