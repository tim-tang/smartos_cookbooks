# Makefile for SmartOS Deployment
#
TAR=gtar
DISTNAME=smartos_cookbooks.tar.gz
SERVER_DEST=hash@173.255.253.43:/srv/www/smartos-cookbooks/

all: 	
	$(TAR) cfz /tmp/$(DISTNAME) cookbooks
	scp /tmp/$(DISTNAME) $(SERVER_DEST)
	rm /tmp/$(DISTNAME)
	scp nodes/* $(SERVER_DEST)
	scp scripts/* $(SERVER_DEST)
	scp keys/* $(SERVER_DEST)
	scp smf/chef-solo.xml $(SERVER_DEST)
	scp Chef-fatclient-SmartOS-10.14.2.tar.bz2 $(SERVER_DEST)


nodes:
	scp nodes/* $(SERVER_DEST)

scripts:
	scp scripts/* $(SERVER_DEST)
	scp smf/chef-solo.xml $(SERVER_DEST)

cookbooks:
	$(TAR) cfz /tmp/$(DISTNAME) cookbooks
	scp /tmp/$(DISTNAME) $(SERVER_DEST)
	rm /tmp/$(DISTNAME)
