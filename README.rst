=========================================
Vagrant setup for local Librarian testing
=========================================

This package contains a Vagrant box definition, provisioning scripts... err, so
basically it contains stuff you need to test Librarian on your
Windows/Linux/Mac machine.

Prerequisites
=============

You will need to install Vagrant_ and VirtualBox_ before you can use these
files. 

Obtaining the files
===================

The files can be obtained from the `GitHub repository`_ by clicking the
download button on the right. You can also use `this link`_. After obtaining
the package, simply unzip it somewhere.

Starting the virtual machine for the first time
===============================================

The first time you want to start the virtual machine, run the ``start.cmd``
(Windows) or ``start.sh`` (Mac/Linux) file. It will take a while to configure
the virtual machine but eventually it will be started and you will be able to
access Librarian at `localhost:8080`_.

The script will prompt for you to press any key to stop the virtual machine.
When you are done testing, you can press any key to stop it.

Rebuilding the virtual machine
==============================

When you start the virtual machine for the first time, it will set up a copy of
Librarian for you to test. This is normally the latest development snapshot. As
such, it can become outdated quickly. After a while, you will want to rebuild
your virtual machine to obtain the latest code. To do this, run the
``rebuild.cmd`` (Windows) or ``rebuild.sh`` (Mac/Linux) file. It will rebuild
and start the virtual machine.

Default username and password
=============================

To access the dashboard, default username and password are 'test' and 'test'
(without quotes). See `About various files`_ for more information if you want
to change them.

Supplying content
=================

During initial startup, the configuration script will create a folder 'uploads'
inside the folder where you unpacked this package. This folder will contain two
subfolders: 'content', and 'files'. You can put content zipballs in the
'content' folder, and they will appear in the "Updates" section (represented by
the satellite dish icon). Any files placed in the `files` folder will become
available under "Files" section.

A good place to obtain the pre-packaged content would be
`archive.outernet.is`_.

About various files
===================

This package contains a few files that may be of interest. Note that you must
rebuild the virtual machine after modifying any of these files.

When editing these files on Windows, please use a programmer's editor that
understands Unix-style newline characters. Notepad is not one of them. We
recommend using SublimeText_.

The first file you want to take a look is USEAUTH. This file tells the virtual
box configuration scripts whether to start Librarian with authentication
enabled or not. With Librarian authentication enabled, dashboard is locked out
with password.

Changing the default username and password can be done by editing the PASSWORD
file. First line in that file is the username and the second line is the
password. Please note that the file **must** contain a single blank line at the 
end.

The VERSION file contains information about the Librarian version that should
be used in the virtual machine. ``master`` will give you the last-released
version. ``develop`` (default) will give you the latest (potentially broken)
development snapshot.

Troubleshooting
===============

If you need to troubleshoot issues during initial setup, you will find
installation log file in the directory where you unpacked this package. The
file is named ``install_log.txt``.

Reporting bugs
==============

If you find errors during virtual machine startup and shutdown, or omissions
and typos in this document, please report these issues to `this package's issue
tracker`_. Issues with Librarian itself should be reported to `Librarian's
issue tracker`_ instead. Same applies to any feature requests you may have.

.. _Vagrant: https://www.vagrantup.com/
.. _VirtualBox: https://www.virtualbox.org/
.. _GitHub repository: https://github.com/Outernet-Project/librarian-testing-vagrant
.. _this link: https://github.com/Outernet-Project/librarian-testing-vagrant/archive/master.zip
.. _`localhost:8080`: http://localhost:8080/
.. _SublimeText: http://www.sublimetext.com/
.. _this package's issue tracker: https://github.com/Outernet-Project/librarian-testing-vagrant/issues
.. _Librarian's issue tracker: https://github.com/Outernet-Project/librarian/issues
.. _archive.outernet.is: http://archive.outernet.is/
