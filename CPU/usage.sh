#!/bin/sh
# https://stackoverflow.com/questions/23367857/accurate-calculation-of-cpu-usage-given-in-percentage-in-linux
output=CPU.log
time=$(date +%s)
echo -n "$time" >> $output

stat0=$(cat /proc/stat | grep cpu)
sleep 1
stat1=$(cat /proc/stat | grep cpu)

CPUs=$(echo "$stat1" | awk '{print $1}')
for CPU in $CPUs
do
  usage1=$(echo "$stat1" | grep "$CPU ")
  user1=$(echo "$usage1" | awk '{print $2}')
  nice1=$(echo "$usage1" | awk '{print $3}')
  sys1=$(echo "$usage1" | awk '{print $4}')
  idle1=$(echo "$usage1" | awk '{print $5}')

  usage0=$(echo "$stat0" | grep "$CPU ")
  user0=$(echo "$usage0" | awk '{print $2}')
  nice0=$(echo "$usage0" | awk '{print $3}')
  sys0=$(echo "$usage0" | awk '{print $4}')
  idle0=$(echo "$usage0" | awk '{print $5}')

  active0=$((user0 + nice0 + sys0))
  active1=$((user1 + nice1 + sys1))

  total0=$((idle0 + active0))
  total1=$((idle1 + active1))

  dt=$((total1 - total0))
  di=$((idle1 - idle0))

  usage=$(awk "BEGIN {printf \"%5.1f\", ($dt - $di)/$dt*100}")

  echo -n " $usage" >> $output
done
echo >> $output
