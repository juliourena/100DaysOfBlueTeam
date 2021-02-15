install
cdrom
lang en_US.UTF-8
keyboard us
network --bootproto=dhcp
rootpw Welcome1
firewall --disabled
selinux --permissive
timezone UTC
bootloader --location=mbr
text
skipx
zerombr
clearpart --all --initlabel
autopart

#auth --enableshadow --passalgo=sha512 --kickstart
authselect  --enableshadow  --passalgo=sha512

firstboot --disabled
eula --agreed
services --enabled=NetworkManager,sshd
user --name=automation --plaintext --password=Welcome1 --groups=wheel
reboot

%packages --ignoremissing --excludedocs
@Core
openssh-clients
openssh-server
wget

# unnecessary firmware
-aic94xx-firmware
-atmel-firmware
-b43-openfwwf
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl100-firmware
-iwl1000-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6000g2a-firmware
-iwl6050-firmware
-libertas-usb8388-firmware
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware
-ql2500-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware
%end

%post --log=/root/post_install.log
yum update -y

# update root certs
wget -O/etc/pki/tls/certs/ca-bundle.crt http://curl.haxx.se/ca/cacert.pem

# sudo
yum install -y sudo

# Add automation to sudoers
cat > /etc/sudoers.d/automation << EOF_sudoers_automation
automation        ALL=(ALL)       NOPASSWD: ALL
EOF_sudoers_automation

/bin/chmod 0440 /etc/sudoers.d/automation
/bin/sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

yum clean all
%end