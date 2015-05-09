#!/bin/bash
# Atomic Clamav Rules for Centos/Baruwa Installer
###################
# This is property of eXtremeSHOK.com
# You are free to use, modify and distribute, however you may not remove this notice.
# Copyright (c) Adrian Jon Kriel :: admin@extremeshok.com
##################
# 
# Originially based on: 
# Atomic Clamav Rules for Centos/Baruwa Installer by
# Jeremy McSpadden ( Flux Labs )
#
# You must have a paid subscription for this to work.
# You can sign-up for a trial or subscription at http://atomicorp.com/amember/aff/go/extremeshok 
#
# INSTALL GUIDE
# wget https://raw.github.com/extremeshok/iredmail-atomic-clamav/master/update-atomic-clamav.sh -O /etc/cron.daily/update-atomic-clamav
# chmod +x /etc/cron.daily/update-atomic-clamav
# 
# edit your username and password
# This file must be in /etc/cron.daily

USER=username
PASS=password

# ==== NO NEED TO EDIT BELOW ===

cd /tmp
wget --user=${USER} --password=${PASS} https://www.atomicorp.com/channels/rules/subscription/VERSION -O /tmp/ATOMICORP_VERSION
CLM=$(grep CLAMAV /tmp/ATOMICORP_VERSION  | awk -F = '{print $2}')

cd /var/lib/clamav; rm -rf ASL*

cd /tmp; 
wget --user=${USER} --password=${PASS} http://www.atomicorp.com/channels/rules/subscription/clamav-${CLM}.tar.gz -O /tmp/atomicorp_clamav.tar.gz
tar -zxf /tmp/atomicorp_clamav.tar.gz 
mv -f /tmp/clamav/* /var/lib/clamav/
chown clam:clam /var/lib/clamav/ASL*
chmod og+r /var/lib/clamav/ASL*

rm -f /usr/src/VERSION
rm -f /tmp/atomicorp_clamav.tar.gz 
rm -rf /tmp/clamav

/etc/init.d/clamd reload
