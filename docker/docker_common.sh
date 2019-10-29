#!/bin/bash

CHANNEL=stable
sudo curl -fsSL https://get.docker.com/ | sh -s -- --mirror Aliyun
sudo mkdir -p /etc/docker
sudo touch /etc/docker/daemon.json
sudo cat > /etc/docker/daemon.json <<EOF
{
  	"registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF
sudo systemctl restart docker
