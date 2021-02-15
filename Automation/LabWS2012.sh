#!/bin/bash 

# ansible-playbook -v ansible/debug_ansible_local.yml

cd /mnt/c/tools/Automation

cmd.exe /c python3 -m http.server --directory ./http &

# setup ansible 
export ANSIBLE_HOST_KEY_CHECKING=False

# Install Windows Server 2012 R2
ws2012r2() {
	./win-packer.exe build -var-file=./WS2012R2-var.json ./WS2012R2-provisioners.json
	'/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe' -T ws start "C:/tools/Automation/output-WS2012R2/WS2012R2.vmx"
	
	ansible-playbook -v -i ./ansible/hosts-dc2012r2 -l dc2012r2 -e "ansible_user=Automation ansible_password=Welcome1 ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore" ./ansible/AD_create.yml
	#ansible-playbook -v -i ./ansible/hosts-dc2012r2 -l dc2012r2 -e "ansible_user=Automation ansible_password=Welcome1 ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore" ./ansible/Monitor_DomainController.yml 
}

# Install Windows 10
w10() {
	./win-packer.exe build -var-file=./W10-var.json ./W10-provisioners.json
	'/mnt/c/Program Files (x86)/VMware/VMware Workstation/vmrun.exe' -T ws start "C:/tools/Automation/output-WIN10/WIN10.vmx"
}

#w10 &
ws2012r2

# Add computer to the domain
# ansible-playbook -v -i ./ansible/hosts-wkstn -l wkstn -e "ansible_user=Automation ansible_password=Welcome1 ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore" ./ansible/W10-ansible.yml

# Install & Configure BlueTeam tools on Windows 
