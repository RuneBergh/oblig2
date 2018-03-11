#!bin/bash

echo "jeg er $(who am i | awk '{print $1}') og  Jeg heter   ${0##*/} "

echo "tid siden sist omstart:  $(uptime | awk '{print $3,$4,$5}')" 

echo "Antall prosesser og tråder: $(cat /proc/stat | grep processes | awk '{print $2}')"

 var=$(cat /proc/stat | grep ctx | awk '{print $2}')

sleep 1 

 var2=$(cat /proc/stat | grep ctx | awk '{print $2}')

count1=$(expr $var2 - $var)
echo $count1

mpstat 1 1 | awk '{if(NR==5) print $3,$5}' | while read usr krnl
do
echo "time in usermode $usr % time in kernel $krnl % "  
done

 var3=$(cat /proc/stat | grep intr | awk '{print $2}')

sleep 1

 var4=$(cat /proc/stat | grep intr | awk '{print $2}')

count2=$(expr $var4 - $var3)
echo $count2
