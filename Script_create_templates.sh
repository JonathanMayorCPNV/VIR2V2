pct destroy 202 --force 1 --purge 1 --destroy-unreferenced-disks 1 2> /dev/null
sleep 5
pveam update
sleep 5
pveam download local debian-11-standard_11.7-1_amd64.tar.zst
pct create 202 local:vztmpl/debian-11-standard_11.7-1_amd64.tar.zst --features keyctl=1,nesting=1,fuse=1 --hostname VIRT-Att-Test --storage local-lvm --password rootroot --rootfs=2 --net0 name=eth0,bridge=vmbr0,ip=dhcp --description "Template de text"
pct start 202
sleep 10
pct push 202 ./Script_install_att.sh /root/Script_install_att.sh
sleep 5
pct exec 202 bash /root/Script_install_att.sh 



pct shutdown 202 --forceStop 1
pct template 202




pct destroy 203 --force 1 --purge 1 --destroy-unreferenced-disks 1 2> /dev/null

pct create 203 local:vztmpl/debian-11-standard_11.7-1_amd64.tar.zst --features keyctl=1,nesting=1,fuse=1 --hostname VIRT-Pen-Test --storage local-lvm --password rootroot --rootfs=2 --net0 name=eth0,bridge=vmbr0,ip=dhcp --description "Template de text"
pct start 203
sleep 10
pct push 203 ./Script_install_pen.sh /root/Script_install_pen.sh
sleep 5
pct exec 203 bash /root/Script_install_pen.sh 


pct shutdown 203 --forceStop 1
pct template 203
