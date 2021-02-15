#!/bin/bash

# setup ansible 
export ANSIBLE_HOST_KEY_CHECKING=False

HOST=Ubuntu
VMRUN="/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe"
UBUNTU_BASE="C:/tools/Automation/output-Ubuntu/Ubuntu.vmx"
GUEST_USERNAME=automation
GUEST_PASSWORD=Welcome1
GUEST_DIR_PATH="D:/tools/Automation"


OpenVswitch() {
	GUEST_NAME="OpenVswitch"
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
	
	echo ["${GUEST_NAME}"] > ansible/hosts-"${GUEST_NAME}"
	echo $GUEST_IP >> ansible/hosts-"${GUEST_NAME}"
	
	#ansible-playbook -v -i ./ansible/hosts-"${GUEST_NAME}" -l "${GUEST_NAME}" -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" ./ansible/install_graylog.yml
	
	echo $GUEST_IP
	echo -e "\e[1;31m[+] Completed ${GUEST_NAME}\e[0m"
}

graylog() {
	GUEST_NAME="graylog"
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
	
	echo ["${GUEST_NAME}"] > ansible/hosts-"${GUEST_NAME}"
	echo $GUEST_IP >> ansible/hosts-"${GUEST_NAME}"
	
	ansible-playbook -v -i ./ansible/hosts-"${GUEST_NAME}" -l "${GUEST_NAME}" -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" ./ansible/install_graylog.yml
	
	echo -e "\e[1;31m[+] Completed ${GUEST_NAME}\e[0m"
}

elkstack() {
	GUEST_NAME="elkstack"
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
	
	echo ["${GUEST_NAME}"] > ansible/hosts-"${GUEST_NAME}"
	echo $GUEST_IP >> ansible/hosts-"${GUEST_NAME}"
	
	ansible-playbook -v -i ./ansible/hosts-"${GUEST_NAME}" -l "${GUEST_NAME}" -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" ./ansible/elk-stack.yml
	
	echo -e "\e[1;31m[+] Completed ${GUEST_NAME}\e[0m"
}

logstash() {
	GUEST_NAME="logstash"
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
	
	echo ["${GUEST_NAME}"] > ansible/hosts-"${GUEST_NAME}"
	echo $GUEST_IP >> ansible/hosts-"${GUEST_NAME}"
	
	ansible-playbook -v -i ./ansible/hosts-"${GUEST_NAME}" -l "${GUEST_NAME}" -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" ./ansible/logstash.yml
	
	echo -e "\e[1;31m[+] Completed ${GUEST_NAME}\e[0m"
}

wazuh() {
	GUEST_NAME="wazuh"
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
	
	echo ["${GUEST_NAME}"] > ansible/hosts-"${GUEST_NAME}"
	echo $GUEST_IP >> ansible/hosts-"${GUEST_NAME}"
	
	ansible-playbook -v -i ./ansible/hosts-"${GUEST_NAME}" -l "${GUEST_NAME}" -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" ./ansible/wazuh.yml
	
	echo -e "\e[1;31m[+] Completed ${GUEST_NAME}\e[0m"
}

FleetDM() {
	GUEST_NAME="FleetDM"
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
	
	echo ["${GUEST_NAME}"] > ansible/hosts-"${GUEST_NAME}"
	echo $GUEST_IP >> ansible/hosts-"${GUEST_NAME}"
	
	#ansible-playbook -v -i ./ansible/hosts-"${GUEST_NAME}" -l "${GUEST_NAME}" -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" ./ansible/install_graylog.yml
	
	echo -e "\e[1;31m[+] Completed ${GUEST_NAME}\e[0m"
}

OpenVswitch