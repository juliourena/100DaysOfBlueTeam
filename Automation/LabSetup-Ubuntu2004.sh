cmd.exe /c python3 -m http.server --directory ./http &

# setup ansible 
export ANSIBLE_HOST_KEY_CHECKING=False

cd /mnt/c/tools/Automation


VMRUN="/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe"
GUEST_NAME="ubuntu2004"
GUEST_USERNAME=automation
GUEST_PASSWORD=Welcome1
GUEST_PATH="C:/tools/Automation/output-ubuntu2004/ubuntu2004.vmx"

ubuntu2004() {
	# Run packer to install the OS 
	./win-packer-1-6-6.exe build ./Ubuntu-20.04.json
	
	# Sleep 10 seconds
	sleep 10
	
	# Change network to Bridged
	awk '!/ethernet0.connectiontype = "nat"/' /mnt/c/tools/Automation/output-ubuntu2004/ubuntu2004.vmx > tmp && mv tmp /mnt/c/tools/Automation/output-ubuntu2004/ubuntu2004.vmx
	
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
	
	# Set the values for the hosts file to use with ansible 
	echo ["${GUEST_NAME}"] > ansible/hosts-"${GUEST_NAME}"
	echo $GUEST_IP >> ansible/hosts-"${GUEST_NAME}"
} 

ubuntu2004