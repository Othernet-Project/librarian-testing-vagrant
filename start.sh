cd "$(dirname "$0")"
vagrant up
echo "============================================================="
echo "Librarian is now available at one of these addresses:        "
echo "                                                             "
echo "    http://localhost:8080/                                   "
echo "    http://127.0.0.1:8080/                                   "
echo "                                                             "
echo "          PRESS ANY KEY TO STOP THE VIRTUAL MACHINE          "
echo "                                                             "
echo "============================================================="
read -n1
echo
vagrant halt
