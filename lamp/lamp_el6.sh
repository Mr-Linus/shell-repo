#!/bin/bash

green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal
#set temp step
clear 
setselinux(){
	echo -n "Closing Selinx ..."
	sleep 0.3
	sed -i  's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
	echo -n "."
	sleep 0.3
	echo -n "."
	i=`setenforce 0`  
	echo -n $i
	echo -n "Config Selinux ....."
	if [ $? == 0 -o $? == 1  ];then
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
	chkconfig $@ on &>/dev/null
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
	service $@ start &>/dev/null
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
install "mysql mysql-server"
install "php"
echo "Installing Extra Tools"
sleep 0.5
install "php-mysql php-gd libjpeg* php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash libmcrypt" 
setcfg "httpd"
setcfg "mysqld"
/bin/cp -rf  /usr/share/mysql/my-huge.cnf /etc/my.cnf 
start "httpd"
start "mysqld"
echo "Set Your MYSQL:"
sleep 3
mysql_secure_installation
echo "reloading Service"
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php
chown apache.apache -R /var/www/html
start "httpd"
start "mysqld"
echo "Would you like to Optimize apache setting ?"
read -p "Please input Y to continue" key
if [ $key == 'Y' -o $key == 'y' ];then
	sed -i  's/#AddHandler cgi-script .cgi/AddHandler cgi-script .cgi/' /etc/httpd/conf/httpd.conf 
	sed -i  's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf 
	sed -i  's/AddDefaultCharset UTF-8/AddDefaultCharset GB2312/' /etc/httpd/conf/httpd.conf 
	start "httpd"
	start "mysqld"
fi
echo "You can check your apache : http://localhost"
echo "You can check your PHP : http://localhost/phpinfo.php"
echo "All of components are installed. Enjoy~"
sleep 3
exit
			

