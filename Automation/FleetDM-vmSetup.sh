# setup ansible 
export ANSIBLE_HOST_KEY_CHECKING=False

cd /mnt/c/tools/Automation

HOST=ubuntu2004
VMRUN="/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe"
UBUNTU_BASE="C:/tools/Automation/output-ubuntu2004/ubuntu2004.vmx"
GUEST_USERNAME=automation
GUEST_PASSWORD=Welcome1
GUEST_DIR_PATH="D:/tools/Automation"

FleetDM() {
	GUEST_NAME="fleetdm"
	GUEST_PATH="${GUEST_DIR_PATH}"/"${GUEST_NAME}"/"${GUEST_NAME}".vmx

	# Clone Server from Ubuntu base Image
	"${VMRUN}" -T ws clone "${UBUNTU_BASE}" "${GUEST_PATH}" full -cloneName="${GUEST_NAME}"
	
	# Start Server 
	"${VMRUN}" -T ws start "${GUEST_PATH}"
	
	# Sleep 5 seconds
	sleep 5
	
	# Get IP Address from Server 
	GUEST_IP=$("${VMRUN}" -T ws getGuestIPAddress "${GUEST_PATH}")
	
	while [[ $GUEST_IP == *"Error:"* ]]
	do
      GUEST_IP=$("${VMRUN}" -T ws getGuestIPAddress "${GUEST_PATH}")
	  sleep 5
	done
	
	echo $GUEST_IP
	
	git clone https://github.com/CptOfEvilMinions/FleetDM-Automation
	cd FleetDM-Automation
	
	echo ["${GUEST_NAME}"] > hosts.ini
	echo $GUEST_IP >> hosts.ini
	
	# Generate TLS private key and Public Certificate
	mkdir -p conf/tls
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout conf/tls/fleet.key -out conf/tls/fleet.crt -subj "/C=DO/ST=DN/L=SantoDomingo/O=SUPERSTORE/CN=superstore.xyz"
	
	# Set the secret key for the feetdm 
	SECRET=$(openssl rand -base64 32)
	sed -i "s|super_secret_key_here|$SECRET|g" group_vars/fleetdm.yml
	
	# Change passwords for mysql & fleetdm user
	sed -i 's/mysql_root_password: '"'"'Changeme123!'"'"'/mysql_root_password: '"'"'Welcome1'"'"'/g' group_vars/fleetdm.yml
	sed -i 's/mysql_fleetdm_password: '"'"'Changeme123!'"'"'/mysql_fleetdm_password: '"'"'Welcome1'"'"'/g' group_vars/fleetdm.yml
	
	# Set base domain name & Timezone
	sed -i 's/base_domain: '"'"'hackinglab.local'"'"'/base_domain: '"'"'superstore.xyz'"'"'/g' group_vars/all.yml
	sed -i 's/timezone: '"'"'Etc\/UTC'"'"'/timezone: '"'"'America\/Santo_Domingo'"'"'/g' group_vars/all.yml
	
	sed -i 's/follow_redirects: none/follow_redirects: all/g' roles/fleetdm/setup_fleetdm.yml
	
	# Run ansible playbook
	ansible-playbook -v -i hosts.ini -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" deploy_fleetdm.yml
	
	echo -e "\e[1;31m[+] Completed ${GUEST_NAME}\e[0m"
}

FleetDM