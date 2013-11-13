#!/bin/sh

# toilet display

# require : blink1-tools command and node.js + json

# get blink1-tool path
BLINK1_PATH=$(which blink1-tool)

# Blink1 devide id suffix
DEVICE_ID_SUFFIX=5

# load settings.ini
. settings.ini

# detect keys
ROOMS="DOOR_13M_01 DOOR_13M_02 DOOR_13M_03 DOOR_13M_04"

# load json
TMP_JSON_FILE=$(mktemp /tmp/toilet.XXX)
curl -s $TOILET_URL > $TMP_JSON_FILE

# counter
C=0
for r in $ROOMS ; do
  # 0 or 1 
  O=$(cat $TMP_JSON_FILE | sed -e 's/(//' -e 's/)//' | json ${r}.state)
  echo $r : $O

  C=$(($C+$O))
  
  # maybe switch better
  # if empty
  if [ $O -eq 0 ] ; then
    echo -- $BLINK1_PATH --id $DEVICE_ID_SUFFIX --green
    $BLINK1_PATH --id $DEVICE_ID_SUFFIX --green
  fi

  # if occupy
  if [ $O -eq 1 ] ; then 
    echo -- $BLINK1_PATH --id $DEVICE_ID_SUFFIX --red
    $BLINK1_PATH --id $DEVICE_ID_SUFFIX --red
  fi 

  DEVICE_ID_SUFFIX=$(($DEVICE_ID_SUFFIX+1))
done

#echo COUNTER : $C
COLOR=("green" "green" "yellow" "yellow" "red")
$BLINK1_PATH --id 0 --${COLOR[$C]}

rm $TMP_JSON_FILE
