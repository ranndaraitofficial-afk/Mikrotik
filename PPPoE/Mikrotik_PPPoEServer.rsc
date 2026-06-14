# 2026-06-14 10:45:51 by RouterOS 7.22.1
# system id = rNTOSREmXIK
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1-WAN
set [ find default-name=ether2 ] disable-running-check=no name=ether2-PPPoE
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
set [ find default-name=ether6 ] disable-running-check=no
set [ find default-name=ether7 ] disable-running-check=no
set [ find default-name=ether8 ] disable-running-check=no
/ip pool
add name=PPPoE-Pool ranges=100.100.100.10-100.100.100.20
/ppp profile
add change-tcp-mss=yes local-address=100.100.100.1 name=PPPoE-Profile \
    remote-address=PPPoE-Pool use-encryption=yes
/interface pppoe-server server
add default-profile=PPPoE-Profile disabled=no interface=ether2-PPPoE \
    service-name=service1
/ip dhcp-client
add interface=ether1-WAN name=client1
/ip firewall nat
add action=masquerade chain=srcnat
/ppp secret
add name=user1 profile=PPPoE-Profile service=pppoe
/system identity
set name=Mikrotik_ISP
