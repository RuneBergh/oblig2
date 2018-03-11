#!/bin/bash
#Hente inn pids og lagre
pids=$(pgrep chrome)
# lagre alle faults for alle pids i en array
faults="$(ps --no-headers -o maj_flt ${pids})"
# legge sammen
sum=$(dc <<< '[+]sa[z2!>az2!>b]sb'"${faults[*]}lbxp")
# Mer enn 1000? legg til melding
over1000=""
if (( sum > 1000 )); then
    over1000=" (mer enn 1000!!!)";
fi

#printe ut
echo "Chrome $(echo $pids | awk '{print $1}')\
 har foraarsaket $sum major page faults $many"#!/bin/bash"
