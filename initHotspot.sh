#!/bin/bash
#initHotspot
#Initial uap0 interface configuration
ifconfig $1 up 10.0.0.1 netmask 255.0.0.0
sleep 2

###########Start dnsmasq, modify if required##########
if [ -z "$(ps -e | grep dnsmasq)" ]
then
 dnsmasq
fi
###########

#Enable NAT
iptables --flush
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain
sudo iptables -t nat -A POSTROUTING -o $2 -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $1 -o $2 -j ACCEPT

#Uncomment the line below if facing problems while sharing PPPoE
#iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

sysctl -w net.ipv4.ip_forward=1

#start hostapd
hostapd /etc/hostapd/hostapd.conf 1> /dev/null
killall dnsmasq
