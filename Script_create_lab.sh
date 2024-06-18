#!/bin/sh
LXC-Attack(){
pct clone 202 $vmid --full 1 --hostname "VM-Attack-$vmid" --description "Clone form the 202" 2> /dev/null
pct start $vmid 
sleep 1
}

LXC-Pentester(){
pct clone 203 $vmid --full 1 --hostname "VM-pentest-$vmid" --description "Clone from template 203" 2> /dev/null
pct start $vmid 
sleep 1
}

for i in $(seq 1 $1)
do
vmid=$(($i + 210))
LXC-Attack $vmid &
done

for i in $(seq 1 $1)
do
vmid=$(($i + 250))
LXC-Pentester $vmid &
done

wait
echo "Voici les ip des machines"

for i in $(seq 1 $1)
do
vmidpen=$(($i + 250))
vmidatt=$(($i + 210))
echo "ip de la vm pen"
pct exec $vmidpen ip a s dev eth0 | sed -n '/inet / s/\// /p' | awk '{print $2}'
echo "ip de la vm att"
pct exec $vmidatt ip a s dev eth0 | sed -n '/inet / s/\// /p' | awk '{print $2}'
done
