#!/bin/sh

# all blinl(1) turn off

BLINK1_PATH=$(which blink1-tool)

# all off
cnt=0
while :
do
  echo count: $cnt
  if ! $BLINK1_PATH -d $cnt --off  ; then
    break
  fi
  cnt=$(($cnt+1))
done
