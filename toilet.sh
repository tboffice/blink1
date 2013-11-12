#!/bin/sh

# toilet display

# Blink1 devide id suffix
DEVICE_ID_SUFFIX=0

# load settings.ini
. settings.ini

# detect keys
ROOMS="DOOR_13M_01 DOOR_13M_02 DOOR_13M_03 DOOR_13M_04"

# load json
TMP_JSON_FILE=$(mktemp /tmp/toilet.XXX)
curl -s $TOILET_URL > $TMP_JSON_FILE

for r in $ROOMS ; do
  cat $TMP_JSON_FILE | sed -e 's/(//' -e 's/)//' | json ${r}.state
done

rm $TMP_JSON_FILE
