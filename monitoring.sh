#!/bin/bash
arc=$(uname -a)
lscpu=$(lscpu | awk '/^Socket\(s\):/ { print $2 }')
vcpu=$(nproc)
tram=$(free -m | awk 'NR==2 { print $2}')
uram=$(free -m | awk 'NR==2 { print $3}')
lcpu=$(uptime | awk '{print $9}' | tr -d ',')
disk_infos=$(df -h / | awk 'NR==2 {print $3, $2, $5}')
read udik adik upm <<< "$disk_infos"
pram=$(awk "BEGIN {printf \"%.2f\", $uram / $tram * 100}")
lbt=$(uptime -s)
if [ -d "/dev/mapper" ]; then
	lvma="yes"
else
	lvma="no"
fi
acon=$(ss -t -a state established | wc -l)
unum=$(who | awk '{print $1}' | sort -u | wc -l)
ipv4=$(ip -o -4 addr show | grep inet | awk 'NR==2 {print $4}')
MAC=$(ip link show | grep ether | awk '{print $2}')
scom=$(journalctl -q _COMM=sudo | grep COMMAND | wc -l)
wall 	"
	#Architecture    : $arc
	#CPU physical    : $lscpu
	#vCPU	         : $vcpu
	#Memory Usage    : $uram"M"/$tram"G" ($pram%)
	#Disk Usage      : $udik/$adik ($upm)
	#CPU load        : $lcpu%
	#Last boot       : $lbt
	#LVM use         : $lvma
	#Connections TCP : $acon
	#User log	 : $unum
	#Network	 : IP $ipv4 ($MAC)
	#Sudo		 : $scom cmd
	"

