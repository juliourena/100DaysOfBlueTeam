#!/bin/bash 

# ansible-playbook -v ansible/debug_ansible_local.yml

cmd.exe /c python3 -m http.server --directory ./http &

# setup ansible 
export ANSIBLE_HOST_KEY_CHECKING=False

cd /mnt/c/tools/Automation

# Install Ubuntu 
ubuntu() {
	./win-packer.exe build ./Ubuntu.json
	# -T ws <- Target VM Workstation 
	'/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe' -T ws start "C:/tools/Automation/output-Ubuntu/Ubuntu.vmx"
}

ubuntu