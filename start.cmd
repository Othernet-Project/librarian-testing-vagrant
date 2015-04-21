@echo off
vagrant up
echo Press any key to stop the virtual machine...
pause > null
echo
vagrant halt
