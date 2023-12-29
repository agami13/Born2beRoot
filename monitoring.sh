#!/bin/bash
arc=$(uname -a)
lscpu=$(lscpu | grep 'Socket(s):' | awk '{ print $2 }')
vcpu=$(lscpu | awk 'NR==5 {print $2}')
tram=$(free -m | awk 'NR==2 { print $2}')
uram=$(free -m | awk 'NR==2 { print $3}')
lcpu=$(uptime | awk '{print $9}' | tr -d ',')
disk_T=$(df --total -h | grep 'total' | awk '{print $2}')
udisk=$(df --total -h | grep 'total' | awk '{print $3}')
upm=$(df --total -h | grep 'total' | awk '{printf "%.2f", $3/$2 * 100}')
pram=$(free -m | awk 'NR==2 {printf "%.2f", $3/$2 * 100}')
lbt=$(uptime -s)
if [ "lsblk | grep 'LVM' | wc -l" ]; then
	lvma="yes"
else
	lvma="no"
fi
acon=$(ss -t -a state established | wc -l)
unum=$(who --count | grep 'users' | tr '=' ' ' | awk '{print $3}')
ipv4=$(hostname -I)
MAC=$(ip link show | grep ether | awk '{print $2}')
scom=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l)
wall 	"
	#Architecture    : $arc
	#CPU physical    : $lscpu
	#vCPU	         : $vcpu
	#Memory Usage    : $uram"M"/$tram"G" ($pram%)
	#Disk Usage      : $udisk/$disk_T ($upm%)
	#CPU load        : $lcpu%
	#Last boot       : $lbt
	#LVM use         : $lvma
	#Connections TCP : $acon ESTABLISHED
	#User log	 : $unum
	#Network	 : IP $ipv4($MAC)
	#Sudo		 : $scom cmd
	"
