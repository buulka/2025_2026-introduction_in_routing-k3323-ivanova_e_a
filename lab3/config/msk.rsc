/user
add name=kate password=123 group=full
set admin disabled=yes
/system identity
set name=R05.MSK

/ip address
add address=10.20.4.2/30 interface=ether1
add address=10.20.5.1/30 interface=ether2

/interface bridge
add name=loopback
/ip address
add address=10.255.255.15/32 interface=loopback network=10.255.255.15

/routing ospf instance
add name=inst router-id=10.255.255.15
/routing ospf area
add name=backbonev2 area-id=0.0.0.0 instance=inst
/routing ospf network
add area=backbonev2 network=10.20.4.0/30
add area=backbonev2 network=10.20.5.0/30
add area=backbonev2 network=10.255.255.15/32

/mpls ldp
set lsr-id=10.255.255.15
set enabled=yes transport-address=10.255.255.15
/mpls ldp advertise-filter
add prefix=10.255.255.0/24 advertise=yes
add advertise=no
/mpls ldp accept-filter
add prefix=10.255.255.0/24 accept=yes
add accept=no
/mpls ldp interface
add interface=ether1
add interface=ether2