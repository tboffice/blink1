#!/bin/sh

# 複数のblink(1)をUSBハブでつないだ時に、順番にランプがつくようにする
# 物理的に順番に並べ替えるために作った

# やってみたけど、物理的に順番を変えた時、並べ替えたあと再度実行するとなぜか順番に点いてくれない
# ということで没
# と思ったけど後日やったらうまく行った

BLINK1_PATH=$(which blink1-tool)
COLOR_CODE=("255,0,0" "255,153,0" "255,255,0" "0,255,0" "0,0,255" "51,0,102" "255,0,255")

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

# rainbow !!!
cnt=0
while :
do
  echo count: $cnt
  sleep 1
  if ! $BLINK1_PATH -d $cnt --rgb ${COLOR_CODE[$(($cnt%${#COLOR_CODE[@]}))]} ; then
    break
  fi
  
  echo soeji: $(($cnt%${#COLOR_CODE[@]}))
  echo COLOR-CODE: ${COLOR_CODE[$(($cnt%${#COLOR_CODE[@]}))]}

  cnt=$(($cnt+1))

done

