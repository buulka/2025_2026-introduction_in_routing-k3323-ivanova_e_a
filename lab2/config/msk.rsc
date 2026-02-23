/system identity
set name=MSK

/user
add name=kate password=123 group=full

/ip address
add address=172.16.1.1/30 interface=ether2
add address=172.16.4.1/30 interface=ether3
add address=10.10.10.1/24 interface=ether4

/ip pool
add name=dhcp_pool_msk ranges=10.10.10.100-10.10.10.200

/ip dhcp-server
add name=dhcp_msk interface=ether4 address-pool=dhcp_pool_msk
enable dhcp_msk

/ip dhcp-server network
add address=10.10.10.0/24 gateway=10.10.10.1

/ip route
add dst-address=10.10.20.0/24 gateway=172.16.1.2
add dst-address=10.10.30.0/24 gateway=172.16.4.2
