#!/bin/sh

# determine multiple blink1 devices

BLINK1_PATH=$(which blink1-tool)
COLOR_CODE=("255,0,0" "255,153,0" "255,255,0" "0,255,0" "0,0,255" "51,0,102" "255,0,255")

cnt=0
while :
do
  echo count: $cnt
  if ! $BLINK1_PATH -d $cnt --off  ; then
    break
  fi
  cnt=$(($cnt+1))
done

cnt=0
while :
do
  echo count: $cnt
  sleep 1
  if ! $BLINK1_PATH -d $cnt --rgb ${COLOR_CODE[$(($cnt%${#COLOR_CODE[@]}))]} ; then
    break
  fi
  
  echo sorji: $(($cnt%${#COLOR_CODE[@]}))
  echo COLOR-CODE: ${COLOR_CODE[$(($cnt%${#COLOR_CODE[@]}))]}

  cnt=$(($cnt+1))
#  echo $cnt

done

