#!/bin/bash

# tries to kill process with highest CPU load
# (if it isn't Xorg)

while true; do
  sleep 20
  TOPPROCESS=$(top -b -n 1 | sed 1,6d | sed -n 2p)
  TOPPID=$(echo "$TOPPROCESS" | awk '{print $1}')
  TOPNAME=$(echo "$TOPPROCESS" | awk '{print $12}')
  TOPCPU=$(echo "$TOPPROCESS" | awk '{print $9}')
  if [ "$TOPNAME" != "Xorg" ] && [ $(echo "$TOPCPU > 80" | bc) -ne 0 ]
  then
    echo "$TOPPROCESS" >> /danger-process.txt
    pstree $TOPPID >> /danger-process.txt
    echo "-----------------------------------------------" >> danger-process/txt
  fi
done

exit 0
