apt-get update -y
apt-get upgrade -y
sleep 5
apt-get install nmap netdiscover crunch lynx sqlmap nano sudo cowsay -y
#apt-get install weevely -y

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
