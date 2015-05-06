# Makefile for SmartOS Deployment
#
TAR=tar
DISTNAME=smartos_cookbooks.tar.gz
SERVER_DEST=173.255.253.43:/srv/www/

all: 	
	$(TAR) cfz /tmp/$(DISTNAME) cookbooks
	scp /tmp/$(DISTNAME) $(SERVER_DEST)
	rm /tmp/$(DISTNAME)
	scp nodes/* $(SERVER_DEST)
	scp scripts/* $(SERVER_DEST)
	scp keys/* $(SERVER_DEST)
	scp smf/chef-solo.xml $(SERVER_DEST)


nodes:
	scp nodes/* $(SERVER_DEST)

scripts:
	scp scripts/* $(SERVER_DEST)
	scp smf/chef-solo.xml $(SERVER_DEST)

cookbooks:
	$(TAR) cfz /tmp/$(DISTNAME) cookbooks
	scp /tmp/$(DISTNAME) $(SERVER_DEST)
	rm /tmp/$(DISTNAME)
