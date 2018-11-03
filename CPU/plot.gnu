#!/usr/bin/gnuplot --persist
# http://hxcaine.com/blog/2013/02/28/running-gnuplot-as-a-live-graph-with-automatic-updates/
set yrange [0:100]
set ylabel "CPU usage [%]"

set xdata time
set timefmt "%s"
set format x "%m/%d\n%H:%M"

plot "CPU.log" using 1:2 title "Total" with lines
pause 5
reread
