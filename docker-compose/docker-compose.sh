#!/bin/bash
green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal
echo -e "Install docker-compose..."
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose &> /dev/null && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
sudo chmod +x /usr/local/bin/docker-compose &> /dev/null
docker-compose --version 