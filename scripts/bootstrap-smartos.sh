#!/bin/bash
# Chef Solo Bootstrap for SmartOS GZ
# See: http://wiki.smartos.org/display/DOC/Using+Chef
# EXAMPLE USE:   curl -s http://173.255.253.43:8000/bootstrap-smartos.sh | bash

if [[ -f /opt/custom/smf/chef-solo.xml && -f /var/chef/solo.rb ]]; then
 echo "WARNING: Chef Solo already installed and configured.  Sleeping for 30s.  Ctl-C to abort."
 sleep 30
fi

# Download and install Chef Fat Client
echo "Download and install Chef Fat Client"
cd /tmp && /usr/bin/curl -Os http://173.255.253.43:8000/Chef-fatclient-SmartOS-10.14.2.tar.bz2
cd / && gtar xfj /tmp/Chef-fatclient-SmartOS-10.14.2.tar.bz2
cp /usr/bin/gtar /opt/chef/bin/tar
mkdir -p /opt/custom/smf /var/chef

# Create Chef Solo Configuration
echo "Create Chef Solo Configuration"
cat >/var/chef/solo.rb  <<END
##
## Joyent Chef Solo Configuration
##
file_cache_path "/var/chef"
cookbook_path "/var/chef/cookbooks"
json_attribs "http://173.255.253.43:8000/smartos.json"
recipe_url "http://173.255.253.43:8000/smartos_cookbooks.tar.gz"
END

if [[ $NODENAME ]]; then
 echo "node_name \"${NODENAME}\"" >>/var/chef/solo.rb
fi

# Install and Import SMF Service for Chef Solo
echo "Install and Import SMF Service for Chef Solo"
cd /opt/custom/smf && /usr/bin/curl -Os http://173.255.253.43:8000/chef-solo.xml
svccfg import /opt/custom/smf/chef-solo.xml

if svcs chef-solo >/dev/null; then
 echo "Installation complete. Chef Solo SMF Service State: `/usr/bin/svcs -Ho state chef-solo`"
fi
