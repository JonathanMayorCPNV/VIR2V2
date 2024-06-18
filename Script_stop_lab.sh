shutdown(){
pct shutdown $i --forceStop 1
sleep 1
}
for i in $(seq 210 255)
do
shutdown $i &

done

wait
echo "everything stop, everyone sleep"
