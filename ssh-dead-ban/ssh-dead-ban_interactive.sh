#!/bin/bash

green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal

read -p "Please enter a number of reconnection:[10]" DEFINE
if [ ! $DEFINE ] ;then
	DEFINE=10
fi	
sudo mkdir /root/satools && touch /root/satools/black.txt
sudo cat /var/log/secure | awk '/Failed/ {print $(NF-3)}' | sort | uniq -c | awk '{print $2"="$1;}' > /root/satools/black.txt
for i in `sudo cat /root/satools/black.txt` 
do 
	IP=`echo $i | awk -F= '{print $1}'`
	NUM=`echo $i | awk -F= '{print $2}'`
	if [ $NUM -gt $DEFINE ]; then
		grep $IP /etc/hosts.deny > /dev/null
		if [ $? -gt 0 ]; then 
			echo -n "Writing to /etc/hosts.deny ..."
			sudo echo "sshd:$IP" >> /etc/hosts.deny
			result=$?
			echo -n "."
			sleep 0.3
			if [ $result == 0 ] ; then
				echo -e "[${green}Success${nc}]"
			else
				echo -e "[${red}Failed${nc}]"
				exit 1
			fi
		fi
	fi
done
echo "Dead list :"
sudo cat /root/satools/black.txt
echo "Deny list :"
sudo cat /etc/hosts.deny
echo "Okey~ enjoy~"
