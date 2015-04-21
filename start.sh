cd "$(dirname "$0")"
vagrant up
read -n1 -p "Press any key to stop the virtual machine..."
echo
vagrant halt
