#!/bin/bash
# set color
green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal
#set temp step
tmp=0
end=`ls -n /sys/class/scsi_host/ | awk 'END{print NR}'`
end=`expr  $end - 1`
clear 


while [ $tmp -lt $end ] 
do
	echo "- - -" > /sys/class/scsi_host/host$tmp/scan
	if [  $? == '0' ]; then
		echo -e "The host$tmp has been updated. [${green}Success${nc}]"
		sleep 0.3
	else 
		echo -e "The host$tmp has been updated. "
		sleep 0.3
	fi
	tmp=`expr  $tmp + 1` 
done  
echo -n "Your SCSI are: " 
ls  /dev/sd?
echo "Update the SCSI Completed"
sleep 3
echo "OK ."
