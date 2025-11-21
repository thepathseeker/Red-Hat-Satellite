#!/usr/bin/env bash
# run this script as root
# before running this script, upgrade the server and reboot if needed
firewall-cmd \
--add-port="8000/tcp" \
--add-port="9090/tcp"

firewall-cmd \
--add-service=dns \
--add-service=dhcp \
--add-service=tftp \
--add-service=http \
--add-service=https \
--add-service=puppetmaster

firewall-cmd --runtime-to-permanent

firewall-cmd --list-all

subscription-manager repos --disable "*"

subscription-manager repos \
--enable=rhel-9-for-x86_64-baseos-rpms \
--enable=rhel-9-for-x86_64-appstream-rpms \
--enable=satellite-6.18-for-rhel-9-x86_64-rpms \
--enable=satellite-maintenance-6.18-for-rhel-9-x86_64-rpms

dnf repolist enabled

dnf upgrade -y

dnf install satellite -y

satellite-installer --scenario satellite \
--foreman-initial-organization "org-sophon" \
--foreman-initial-location "loc-homelab" \
--foreman-initial-admin-username admin \
--foreman-initial-admin-password katello-enabler
