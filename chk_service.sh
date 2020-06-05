#!/bin/bash
chk1(){
	for i in bluetooth.service cups.service ddclient.service dhcpcd.service dnsmasq.service hostapd.service lightdm.service vncserver-x11-serviced.service motioneye.service
	do systemctl is-active $i  >/dev/null 2>&1 && echo -e "$i \e[32mrunning\e[0m" || echo -e "$i \e[31mNot running\e[0m"
	done
}
args="$@"
services="bluetooth.service cups.service ddclient.service dhcpcd.service dnsmasq.service hostapd.service lightdm.service vncserver-x11-serviced.service motioneye.service"
if [ $# -lt 1  ] 
then
	chk1
else
	for i in $args; do systemctl is-active $i  >/dev/null 2>&1  && echo -e "$i service \e[32mrunning\e[0m" || echo -e "$i service \e[31mNot running\e[0m" ; done
fi
