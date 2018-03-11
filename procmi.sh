#!/bin/bash
# Iterate all arguments
for var in "$@"
do
    vmem_total="$(grep VmSize /proc/$var/status | awk '{print $2}')"
    vmem_private="$(grep -E VmData\|VmStk\|VmExe /proc/$var/status \
        | awk '{print $2}')"
    # Sum vmem private with dc calculator
    vmem_private_sum="$(dc <<< '[+]sa[z2!>az2!>b]sb'"${vmem_private[*]}lbxp")"
    vmem_shared="$(grep VmLib /proc/$var/status | awk '{print $2}')"
    pmem_total="$(grep VmRSS /proc/$var/status | awk '{print $2}')"
    fmem_page="$(grep VmPTE /proc/$var/status | awk '{print $2}')"

    # Date and fileending for our files
    filename="$var-$(date --iso-8601=seconds).meminfo"

    # Write to disk
    echo -e "******** Minne info om prosess med PID $var ********"\
        > "$filename"
    echo -e "Total bruk av virtuelt minne (VmSize):\t\t\t\t$vmem_total KB"\
        >> "$filename"
    # This has to be done to avoid exceeding 79 char width
    p="Mengde privat virtuelt minne (VmData+VmStk+VmExe):\t\t"
    p="$p$vmem_private_sum KB"
    echo -e "$p" >> "$filename"
    echo -e "Mengde shared virtuelt minne (VmLib):\t\t\t\t$vmem_shared KB"\
        >> "$filename"
    echo -e "Total bruk av fysisk minne (VmRSS):\t\t\t\t$pmem_total KB"\
        >> "$filename"
    # This has to be done to avoid exceeding 79 char width
    vmpte="Mengde fysisk minne som benyttes til page table (VmPTE):\t"
    vmpte="$vmpte$fmem_page KB"
    echo -e "$vmpte" >> "$filename"
done
