#!/bin/bash

green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal
#set temp step
clear 
# show system info
setselinux(){
	echo -n "Closing Selinx ..."
	sleep 0.3
	sed -i  's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
	echo -n "."
	sleep 0.3
	echo -n "."
	setenforce 0 >/dev/null 
	result=$?
	echo -n "Config Selinux ....."
	if [ $result == 0 -o $result == 1  ];then
		echo -e " [${green}Success${nc}]"
	else
		echo -e "[${red}Failed${nc}]"
		echo "Please check your config.."
		exit 2
	fi
}
install(){
	echo -n "Install $@ ..."
	sleep 0.3
	yum install -y $@ &>/dev/null
	i=$?
	echo -n "."
	sleep 0.3
	if [ $i == 0 ];then
		echo -e "[${green}Success${nc}]"
	else
		echo -e "[${red}Failed${nc}]"
		echo "Please check your config.."
		exit 3
	fi
}
setcfg(){
	sleep 0.3
	systemctl enable $@ &>/dev/null
	echo -n "Setting start-up ..."
	i=$? 
	echo -n '.'
	sleep 0.3
	if [ $i == 0 ];then
		echo -e "[${green}Success${nc}]"
	else
		echo -e "[${red}Failed${nc}]"
		echo "Please check your config.."
		exit 4
	fi	
}
start(){
	echo -n "Starting $@ ..."
	sleep 0.3
	systemctl restart $@ &>/dev/null
	i=$?
	echo -n "."
	sleep 0.3
	if [ $i == 0 ];then
		echo -e "[${green}Success${nc}]"
	else
		echo -e "[${red}Failed${nc}]"
		echo "Please check your config.."
		exit 5
	fi	
}


setselinux
install "httpd" 
install "mariadb mariadb-server"
install "php"
echo "Installing Extra Tools"
sleep 0.5
install "php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash" 
setcfg "httpd"
setcfg "mariadb"
/bin/cp -rf  /usr/share/mysql/my-huge.cnf /etc/my.cnf 
start "httpd"
start "mariadb"
echo "Set Your MYSQL:"
sleep 3
mysql_secure_installation
echo "reloading Service"
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
chown apache.apache -R /var/www/html
start "httpd"
start "mariadb"
echo "Would you like to Optimize apache setting ?"
read -p "Please input Y to continue" key
if [ $key == 'Y' -o $key == 'y' ];then
	sed -i  's/#AddHandler cgi-script .cgi/AddHandler cgi-script .cgi/' /etc/httpd/conf/httpd.conf 
	sed -i  's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf 
	sed -i  's/AddDefaultCharset UTF-8/AddDefaultCharset GB2312/' /etc/httpd/conf/httpd.conf 
	start "httpd"
	start "mariadb"
fi
echo "You can check your apache : http://localhost"
echo "You can check your PHP : http://localhost/phpinfo.php"
echo "All of components are installed. Enjoy~"
sleep 3
exit
	
