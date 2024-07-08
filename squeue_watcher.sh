#!/bin/sh
#Run this using ->  bash squeue_watcher.sh username
usr=$1
linenumber=1
for CYCLE in $(seq 1 100)
do
echo "cycle number ${CYCLE} /100"
date +'%r'
squeue -u $"usr"
linenumber2=$(squeue -u $"usr" | wc -l)
if [[ $linenumber -ne $linenumber2 ]]; then
diff=$((linenumber2 - linenumber))
echo "difference is $diff"
else
echo "no change"
fi
linenumber=$linenumber2
echo "jobs running"
join -2 2 <(squeue -u $usr | awk 'NR > 1 {print $3}' | sort | uniq)\
	        <(squeue -u $usr | awk 'NR >	1 {print $3}' | sort | uniq -c)
echo ""
echo ""
sleep 300
done
echo "iterations run. script exiting"
echo ""
echo ""
exit
