#!/bin/bash
sudo apt-get install wget
echo -n "Downloading Python3.6.5...."
sudo wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Unziping Packages...."
sudo xz -d Python-3.6.5.tar.xz &> /dev/null 
sudo tar xf Python-3.6.5.tar -C /usr/local/src/ &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Configure..."
sudo cd /usr/local/src/Python-3.6.5/
sudo ./configure --prefix=/usr/local/python3.6.5 &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Compile....."
sudo make -j 8 &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Install....."
sudo make install &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo -n "Linking....."
sudo ln -s /usr/local/python3.6.5/bin/pip3  /usr/bin/pip3
sudo ln -s /usr/local/python3.6.5/bin/python3.6 /usr/bin/python3 &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
echo "PATH=/usr/local/python3.6.5/bin/:\$PATH " >> /etc/profile
echo "PYTHONPATH=/usr/local/python3.6.5/lib/python3.6/:/usr/local/python3.6.5/lib/python3.6/site-packages/" >> /etc/profile
sudo source /etc/profile
V3=`python3 -V | awk '{print $2}'`
echo "Python Version: $V3 "
echo "You can input \"python3\" to enter python 3.6.5 and input \"pip3\" to manage your python3 packages."
