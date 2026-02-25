/system identity
set name=HKI

/user
add name=kate password=123 group=full
set admin disabled=yes

/interface bridge
add name=lo

/ip address
add address=10.20.2.2/30 interface=ether1
add address=10.20.3.1/30 interface=ether2
add address=192.168.12.1/24 interface=ether3

/ip pool
add name=dhcp-pool ranges=192.168.12.10-192.168.12.100
/ip dhcp-server
add address-pool=dhcp-pool disabled=no interface=ether3 name=dhcp-server
/ip dhcp-server network
add address=192.168.12.0/24 gateway=192.168.12.1

/interface bridge
add name=loopback
/ip address
add address=10.255.255.13/32 interface=loopback network=10.255.255.13

/routing ospf instance
add name=inst router-id=10.255.255.13
/routing ospf area
add name=backbonev2 area-id=0.0.0.0 instance=inst
/routing ospf network
add area=backbonev2 network=10.20.2.0/30
add area=backbonev2 network=10.20.3.0/30
add area=backbonev2 network=192.168.12.0/24
add area=backbonev2 network=10.255.255.13/32

/mpls ldp
set lsr-id=10.255.255.13
set enabled=yes transport-address=10.255.255.13
/mpls ldp advertise-filter
add prefix=10.255.255.0/24 advertise=yes
add advertise=no
/mpls ldp accept-filter
add prefix=10.255.255.0/24 accept=yes
add accept=no
/mpls ldp interface
add interface=ether1
add interface=ether2

/interface bridge
add name=vpn
/interface vpls
add disabled=no name=PC remote-peer=10.255.255.14 cisco-style=yes cisco-style-id=300
/interface vpls
add disabled=no name=SGI remote-peer=10.255.255.11 cisco-style=yes cisco-style-id=100
/interface bridge port
add interface=ether3 bridge=vpn
add interface=PC bridge=vpn
add interface=SGI bridge=vpn