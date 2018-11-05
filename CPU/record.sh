#!/bin/bash

function ctrl_c_pressed() {
  echo "Done."
  sed -i '$ d' CPU.log
  exit $?
}

trap ctrl_c_pressed INT

echo -n "Recording CPU usage to CPU.log ... "
while true
do
  sh usage.sh
done
