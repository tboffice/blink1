#!/bin/sh

# all blinl(1) turn off

BLINK1_PATH=$(which blink1-tool)
$BLINK1_PATH --id all --off

