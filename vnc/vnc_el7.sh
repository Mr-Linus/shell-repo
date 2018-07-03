#!/bin/bash
cat << EOF
=========================================================================
______           _          
|  ___|         | |         
| |_ _   _ _ __ | | ___   _ 
|  _| | | | '_ \| |/ / | | |
| | | |_| | | | |   <| |_| |
\_|  \__,_|_| |_|_|\_\\__, |
                       __/ |
                      |___/ 
					  
欢迎使用VNC安装脚本
=========================================================================
Author: Mr Funky <QQ:708863861>
=========================================================================
USER: $USER   HOST: $HOSTNAME  KERNEL: `uname -r`  
DISK :`ls  /dev/?d? 2>/dev/null`
EOF
sleep 1
yum check-update -y
yum groupinstall "X Window System" -y
yum install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts -y
unlink /etc/systemd/system/default.target
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
yum install tigervnc-server -y
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
sed -i 's/<USER>/root/' /etc/systemd/system/vncserver@:1.service
systemctl daemon-reload
firewall-cmd --permanent --add-service vnc-server  & > /dev/null
systemctl restart firewalld.service 
iptables -F
service iptables save
echo "设置VNC密码"
vncpasswd
echo "安装完成:VNC Server: <IP>:1"

