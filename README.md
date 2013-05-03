DIY-Perl-OpenShift-Cartridge
====================

Steps to support Perl 5.16 or newer version on OpenShift



Create new DIY app from rhc
----------------
Create new app using diy-0.1 cartridge, then
	rhc ssh -a yourdiyapp 


download & build perl from source:

	cd ~/app-root/data/download
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
	> cpan[1]	notest install Mojolicious DBD::Pg DBD::SQLite Plack Starman other_modules
	> quit



To start you own Starman/Plackup run on host $OPENSHIFT_INTERNAL_IP and on port $OPENSHIFT_INTERNAL_PORT (usually port 8080)  :

	cd ~/app-root/data/perl-new/bin
	./perl plackup --host $OPENSHIFT_INTERNAL_IP --port $OPENSHIFT_INTERNAL_PORT ~/approot/runtime/repo/diy/myapp.pl 


You can edit .openshift/start to autostart your webserver.
And .openshift/stop to stop your webserver.






