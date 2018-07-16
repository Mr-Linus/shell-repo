#!/bin/bash
echo -e "Install docker-compose..."
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose &> /dev/null && echo  -e   "Success" || echo -e "Failed"
sudo chmod +x /usr/local/bin/docker-compose &> /dev/null
docker-compose --version 