# PixieBoardHotSpotScript
For more information on how to use this script you can take a look at this guide: [Internet Sharing with PixieBoard](https://medium.com/pixieboard/internet-sharing-with-pixieboard-94cff1c61f66)

## Sync/Update/Install packages
```sh
$ sudo pacman -Syu
$ sudo pacman -S socat net-tools hostapd dnsmasq
``` 
## Configure Hostapd
```sh
$ sudo nano /etc/hostapd/hostapd.conf
``` 
Copy and save the file with the following information:
```sh
interface=uap0
driver=nl80211
ieee80211n=1
ssid=PixieSharing
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=hellopixiepro123
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
``` 
## Edit or Create dnsmas.conf
```sh
$ sudo nano /etc/dnsmasq.conf
``` 
Copy the following at the end of the file:
```sh
no-resolv
interface=uap0
dhcp-range=10.0.0.3,10.0.0.50,12h
server=8.8.8.8
server=8.8.4.4
``` 

## Make the script executable
```sh
$ sudo chmod +x initHotspot.sh
``` 

## Create a Network Interface
```sh
$ sudo iw phy phy0 interface add uap0 type __ap
``` 

## Execute the Script
Make sure you PixieBoard is connected to the internet through WiFi or cellular modem. Replace <internet_interface> with either wlp1s0 or wwan0 depening how the PixieBoard is connected to the internet.
```sh
$ sudo ./initHotspot.sh uap0 <internet_interface>
``` 

