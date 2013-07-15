DIY-Perl-OpenShift-Cartridge
====================

Steps to support Perl 5.16 or newer version on OpenShift.com


Steps:
--------

Create new app using diy-0.1 cartridge:

	rhc app create diyapp diy-0.1
	rhc ssh -a diyapp


Download & Build new version of Perl from source:

	cd ~/app-root/data/
	mkdir download
	cd download
	wget -c -nd http://www.cpan.org/src/5.0/perl-5.16.3.tar.gz
	tar -xf perl-5.16.3.tar.gz
	cd perl-5.16.3
	./Configure -des -Dprefix=~/app-root/data/perl-new
	make 
	make install
	cd ~/app-root/data/perl-new/bin
	./perl -v

Then install additional Perl modules:

	cd ~/app-root/data/perl-new/bin
	HOME=~/app-root/data/ ./perl cpan
	> cpan[1]    notest install Dancer Mojolicious DBD::Pg DBD::SQLite DBD::mysql and_other_modules
	> quit


Roll your own webserver
----------------------

To start your own web server run on host $OPENSHIFT_INTERNAL_IP and on port $OPENSHIFT_INTERNAL_PORT (usually port 8080)  :

	cd ~/app-root/data/perl-new/bin
	./perl morbo --listen 'http://$OPENSHIFT_INTERNAL_IP:$OPENSHIFT_INTERNAL_PORT' ~/app-root/runtime/repo/diy/mojoapp.pl


However, Please edit this file:

	.openshift/action_hooks/start

to 

	#!/bin/bash
	nohup ~/app-root/data/perl-5.16.3/bin/perl ~/app-root/data/perl-5.16.3/bin/morbo --listen 'http://$OPENSHIFT_INTERNAL_IP:$OPENSHIFT_INTERNAL_PORT' ~/app-root/runtime/repo/diy/mojoapp.pl > /dev/null  2>&1 &

to autostart your webserver.


and also:

	.openshift/action_hooks/stop

to

	#!/bin/bash
	kill `ps -ef | grep morbo | grep -v grep | awk '{ print $2 }'` > /dev/null 2>&1
	exit 0

to stop your webserver.




Test on your browser:
----------------------

	http://[diyapp]-[yournamespace].rhcloud.com



Maintenance
------------

To stop/start/restart your app:

	rhc ssh -a diyapp 
	
	ctl_app stop
	ctl_app start
	ctl_app restart
	
	ctl_all stop
	ctl_all start
	ctl_all restart


Remember to always stop your webserver before running git push.
	
	rhc ssh -a diyapp
	ctl_app stop
	exit
	git push



