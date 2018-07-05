#!/bin/bash
echo -n "Install Development Tools.."
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc wget make xz &> /dev/null && echo -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Downloading Python3.6.5...."
wget http://mirrors.sohu.com/python/3.6.5/Python-3.6.5.tar.xz &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Unziping Packages...."
xz -d Python-3.6.5.tar.xz &> /dev/null 
tar xf Python-3.6.5.tar -C /usr/local/src/ &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Configure..."
cd /usr/local/src/Python-3.6.5/
./configure --prefix=/usr/local/python3.6.5 &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Compile....."
make -j 8 &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Install....."
make install &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Linking....."
ln -s /usr/local/python3.6.5/bin/pip3  /usr/bin/pip3
ln -s /usr/local/python3.6.5/bin/python3.6 /usr/bin/python3 &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo "PATH=/usr/local/python3.6.5/bin/:\$PATH " >> /etc/profile
echo "PYTHONPATH=/usr/local/python3.6.5/lib/python3.6/:/usr/local/python3.6.5/lib/python3.6/site-packages/" >> /etc/profile
source /etc/profile
V3=`python3 -V | awk '{print $2}'`
echo "Python Version: $V3 "
echo "You can input \"python3\" to enter python 3.6.5 and input \"pip3\" to manage your python3 packages."