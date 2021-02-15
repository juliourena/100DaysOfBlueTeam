#!/bin/bash 

# ansible-playbook -v ansible/debug_ansible_local.yml

cmd.exe /c python3 -m http.server --directory ./http &

# setup ansible 
export ANSIBLE_HOST_KEY_CHECKING=False

cd /mnt/c/tools/Automation

# Install Windows Server 2019
wserver2019() {
	./win-packer.exe build -var-file=./W2019-var.json ./W2019-provisioners.json
	'/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe' -T ws start "C:/tools/Automation/output-WS2019_Automation/WS2019_Automation.vmx"
	
	ansible-playbook -v -i ./ansible/hosts-dc -l dc -e "ansible_user=Automation ansible_password=Welcome1 ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore" ./ansible/AD_create.yml
	ansible-playbook -v -i ./ansible/hosts-dc -l dc -e "ansible_user=Automation ansible_password=Welcome1 ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore" ./ansible/Monitor_DomainController.yml 
}

# Install Windows 10
w10() {
	./win-packer.exe build -var-file=./W10-var.json ./W10-provisioners.json
	'/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe' -T ws start "C:/tools/Automation/output-WIN10/WIN10.vmx"
}

# Install Ubuntu 
ubuntu() {
	./win-packer.exe build ./Ubuntu.json
	# -T ws <- Target VM Workstation 
	'/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe' -T ws start "C:/tools/Automation/output-Ubuntu-ELK/Ubuntu-ELK.vmx"
	
	# Configure ElasticSearch 
	ansible-playbook -v -i ansible/hosts-ubuntu -l ubuntu -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" ansible/change_ip.yml
	ansible-playbook -v -i ansible/hosts-ubuntu-5 -l ubuntu -e "ansible_user=automation ansible_password=Welcome1 ansible_become_password=Welcome1" ansible/elk-stack.yml
}

w10 &
ubuntu &
wserver2019

# Add computer to the domain
ansible-playbook -v -i ./ansible/hosts-wkstn -l wkstn -e "ansible_user=Automation ansible_password=Welcome1 ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore" ./ansible/W10-ansible.yml

# Install & Configure BlueTeam tools on Windows 
