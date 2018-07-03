#!/bin/bash

green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal
#set temp step
clear 

backup(){
	echo -n "Backuping YUM Repos . . ."
	sleep 0.3 
	echo -n "." 
	rename .repo .back *.repo &>/dev/null
	if [ $? == 0 ] ; then
		echo -e "[${green}Success${nc}]"
	else
		echo -e "[${red}Failed${nc}]"
		exit 1
	fi
}

download(){
	echo -n "Downloading YUM Repos . . ."
	sleep 0.3 
	echo -n "."
	wget -O /etc/yum.repos.d/Centos-Base.repo $1
	if [ $? == 0 ] ; then
		echo -e "[${green}Success${nc}]"
	else
		echo -e "[${red}Failed${nc}]"
		exit 1
	fi
}








cat << EOF
Download：
Choose your system Type:
(1)Centos \ Red Hat 7
(2)Centos \ Red Hat 6
(3)Centos \ Red Hat 5
EOF
read -p "Please input the number:" key
	case $key in
		1)
			backup
			wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
			download  http://mirrors.aliyun.com/repo/Centos-7.repo
			sed -i 's/$releasever/7/g' /etc/yum.repos.d/Centos-Base.repo
			echo -n "Installing ..."
			rpm --import http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-7
			result=$?
			echo -n "."
			sleep 0.3
			if [ $result == 0 ] ; then
				echo -e "[${green}Success${nc}]"
			else
				echo -e "[${red}Failed${nc}]"
			exit 1
			fi
		;;
		2)
			backup
			wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo
			download  http://mirrors.aliyun.com/repo/Centos-6.repo
			sed -i 's/$releasever/6/g' /etc/yum.repos.d/Centos-Base.repo
			rpm --import http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6
			echo -n "Installing ..."
			result=$?
			echo -n "."
			sleep 0.3
			if [ $result == 0 ] ; then
				echo -e "[${green}Success${nc}]"
			else
				echo -e "[${red}Failed${nc}]"
			exit 1
			fi
		;;
		3)	
			backup
			wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-5.repo
			download  http://mirrors.aliyun.com/repo/Centos-5.repo
			sed -i 's/$releasever/5/g' /etc/yum.repos.d/Centos-Base.repo
			rpm --import http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-5
			echo -n "Installing ..."
			result=$?
			echo -n "."
			sleep 0.3
			if [ $result == 0 ] ; then
				echo -e "[${green}Success${nc}]"
			else
				echo -e "[${red}Failed${nc}]"
			exit 1
			fi
		;;
		*)
			exit
		;;
	esac
	yum clean all
	yum repolist
	if [ $? == 0 ] ; then
				echo -e "[${green}OK${nc}]"
			else
				echo -e "[${red}Failed${nc}]"
			exit 1
			fi

	
	
