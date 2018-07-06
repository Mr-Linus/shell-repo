#!/bin/bash
green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal
cat << EOF
Choose the service you want to run:
(1)mesos-master
(2)mesos-slave
(3)marathon
(4)marathon-lb
EOF
read -p "Please input the number:" key
	case $key in
		1)
			echo -n "Installing ..."
			./mesos-master/mesos-server.sh
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
            echo -n "Installing ..."
			./mesos-slave/mesos-slave.sh
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
            echo -n "Installing ..."
			./marathon/marathon.sh
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
        4)
            echo -n "Installing ..."
			./marathon-lb/marathon-lb.sh
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
    esac
