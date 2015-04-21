# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "terrywang/archlinux"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provider "virtualbox" do |vb|
     vb.memory = "256"
     vb.name = "librarian_testing"
  end
  config.vm.provision "shell", inline: <<-SHELL
     set -e

     LOG=/vagrant/install_log.txt
     echo '' > $LOG

     # Pyton version
     PYVER=$(cat /vagrant/config/PYTHON)
     PYTHON="python${PYVER}"
     PIP="pip${PYVER} -q"

     # Librarian version
     VERSION=$(cat /vagrant/config/VERSION)
     PKG="https://github.com/Outernet-Project/librarian/archive/${VERSION}.zip"

     # patch_copy(name)
     #
     # Patch and copy a service named $name.
     #
     patch_copy() {
       cat "/vagrant/etc/${1}.service.in" \
         | sed "s/PYTHON/$PYTHON/" \
         > "/etc/systemd/system/${1}.service"
     }

     PACMAN="pacman --noprogress --noconfirm"
     $PACMAN -Sy >> $LOG 2>&1

     # Install reflector to sort mirrors
     echo ">>> GENERATING NEW MIRROR LIST ... "
     $PACMAN -S --needed reflector >> $LOG 2>&1
     reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist \
         >> $LOG 2>&1 
     echo DONE

     # Update system packages
     echo ">>> UPDATING SYSTEM PACKAGES (sit tight, may take a while) ... "
     $PACMAN -Su >> $LOG
     if [ "$PYVER" == 2 ]; then
       PKGS="python2 python2-pip"
     else
       PKGS="python python-pip"
     fi
     $PACMAN -S --needed $PKGS libev gettext >> $LOG 2>&1
     echo DONE

     # Install Librarian and its dependencies
     echo ">>> INSTALLING LIBRARIAN ... "
     $PIP install --upgrade "$PKG" >> $LOG
     echo DONE

     # Compile translations
     echo ">>> COMPILING TRANSLATIONS ... "
     LIBDIR=$(dirname $($PYTHON -c 'import librarian;print(librarian.__file__)'))
     for po in $(find $LIBDIR -name *.po); do
       mopath="$(dirname $po)/librarian.mo"
       # It's ok to continue even if next command fails
       msgfmt -o "$mopath" "$po" 2>/dev/null || true
     done
     echo DONE

     # Copy system services
     echo ">>> INSTALLING SYSTEM SERVICES ... "
     patch_copy librarian
     patch_copy librarian-na
     echo DONE

     # Enable default system service
     echo ">>> ENABLING SYSTEM SERVICE ... "
     if [ $(cat /vagrant/config/USEAUTH) == "yes" ]; then
         systemctl enable librarian.service >> $LOG 2>&1
     else
         systemctl enable librarian-na.service >> $LOG 2>&1
     fi
     echo DONE

     # Create superuser
     echo ">>> CREATING SUPERUSER ... "
     cat /vagrant/config/PASSWORD | $PYTHON -m librarian.app --su >> $LOG 2>&1
     echo DONE

     echo ">>> SETTING UP DIRECTORIES ... "
     mkdir -p /vagrant/uploads/{content,files}
     ln -s /vagrant/uploads /var/spool/downloads
     mkdir -p /srv/zipballs
     mkdir -p /var/lib/outernet
     chown vagrant.vagrant /srv/zipballs /var/spool/downloads \
         /var/lib/outernet
     echo DONE

     echo ">>> REBOOTING, PLEASE WAIT A FEW MOMENTS"
     reboot
  SHELL
end
