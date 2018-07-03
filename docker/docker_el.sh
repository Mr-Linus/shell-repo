#!/bin/bash

green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal

echo "Do you want to install Docker accelerated by AliYun ?"
read -p "Please input Y to continue" key2
if [ $key2 == 'Y' -o $key2 == 'y' ];then
		echo "Please Wait ..."
		mkdir -p /etc/docker
		touch /etc/docker/daemon.json
		cat > /etc/docker/daemon.json <<EOF
{
  	"registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF
fi
sudo yum remove docker docker-common docker-selinux  docker-engine
yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo  https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum clean all && yum repolist
yum makecache fast
yum install docker-ce
systemctl enable docker
sudo systemctl daemon-reload && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"
sudo systemctl restart docker && echo  -e   "[${green}Success${nc}]" || echo -e "[${red}Failed${nc}]"


