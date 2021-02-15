#version=RHEL8

# Autopartition as lvm without home partition (CHANGED)
ignoredisk --only-use=sda
autopart --type=lvm --nohome

# Partition clearing information
clearpart --none --initlabel

# Use graphical install
graphical

# Use CDROM installation media
cdrom

# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'

# System language
lang en_US.UTF-8

# Network information - disable ipv6 (CHANGED)
network  --bootproto=dhcp --device=eth0 --noipv6 --activate
network  --hostname=localhost.localdomain

repo --name="AppStream" --baseurl=file:///run/install/repo/AppStream

# Root password
rootpw Welcome1

# Don't run the Setup Agent on first boot (CHANGED)
firstboot --disable

# Enable firewall with ssh allowed (ADDED)
firewall --enabled --ssh

# Do not configure the X Window System
skipx

# System services (ADDED VMTOOLS)
services --disabled="chronyd"
services --enabled="vmtoolsd"

# System timezone (not UTC in VM environment) (CHANGED)
timezone America/Chicago

# Add ansible service account and add to 'wheel' group
user --groups=wheel --name=ansible --password=$6$D5GqhqMWaRMWrrGP$WVktoxs2QAhyEtozouyUEwjMFShVGEXUvKJ0hG89LW38jU1Uax5tCkFvp4O3z0piP3NiSV34XBn6qQk3RwfQ5. --iscrypted --gecos="ansible"

# Reboot after installation (ADDED)
reboot

%packages
@^minimal-environment
wget
open-vm-tools

%end

%addon com_redhat_kdump --disable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end