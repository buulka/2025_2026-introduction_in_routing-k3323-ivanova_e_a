/user
add name=kate password=123 group=full
set admin disabled=yes
/system identity
set name=R02.LND

/ip address
add address=10.20.1.2/30 interface=ether1
add address=10.20.2.1/30 interface=ether2

/interface bridge
add name=loopback
/ip address
add address=10.255.255.12/32 interface=loopback network=10.255.255.12

/routing ospf instance
add name=inst router-id=10.255.255.12
/routing ospf area
add name=backbonev2 area-id=0.0.0.0 instance=inst
/routing ospf network
add area=backbonev2 network=10.20.1.0/30
add area=backbonev2 network=10.20.2.0/30
add area=backbonev2 network=10.255.255.12/32

/mpls ldp
set lsr-id=10.255.255.12
set enabled=yes transport-address=10.255.255.12
/mpls ldp advertise-filter
add prefix=10.255.255.0/24 advertise=yes
add advertise=no
/mpls ldp accept-filter
add prefix=10.255.255.0/24 accept=yes
add accept=no
/mpls ldp interface
add interface=ether1
add interface=ether2