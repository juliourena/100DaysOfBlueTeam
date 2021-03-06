# 100 Days Of BlueTeam 

This is the path I took for my journey, [#100DaysOfBlueTeam](https://twitter.com/search?q=%23100DaysOfBlueTeam) with some modifications &amp; recommendations for those who want to learn more about Blue Team. 

I'll update this post and provide resources and materials I used to learn more about blue team.

# My Journey
I started this journey without a clear plan of what I want to learn, I have some topics in mind but I thought it would be good to just start and identify areas of interest while studying those topics.

My idea for the journey was basically better understand how to do threat hunting on Windows environments, so in order to do that I need different data sources, events, network traffic, files, registry changes, etc. My question was which tools can I use to do that? I first think on [THE HELK](https://github.com/Cyb3rWard0g/HELK) project to collect events and start playing with it, but I later decide to better understand how the ELK Stack works and I did some basic training. As I move forward, I start identifying other areas of interest like vulnerability management, file integrity monitoring, hardening, etc. 

After my 100 days, I think I have a better picture on how I would organize my path if I have to do it again and I want to share that with you. 

Things I learned during the journey:
-	Lab Building & Automation 
-	Host & Network Monitoring
-	Windows Events Collection 
-	Network Event Collection 
- Threat Hunting
-	Vulnerability Management 
- Threat Intelligence 

## Lab Building & Automation
If you are planning to learn something you need to do it, you need to see it working and failing, understanding the theory is necessary, but you also need to practice. I spent a lot of days learning automation and it was one of the things I love the most from this journey. 

Before we jump in the recommendation for this section, it’s important for you to know there are many types of labs you can create and with different hardware requirements and hypervisors. 

My setup is a Windows 10 computer and I use VMWare workstation Pro, but you can use any other OS or Hypervisors.

Full Lab Hardware requirements: 32GB RAM, 500 GB HDD/SSD
-	Firewall – 1GB
-	Switch – 1GB
-	2 Workstation – 4 GB (2GB each) 
-	1 Active Directory Server – 4GB
-	1 Linux Server with the monitoring tools – 12 GB (it may be 2 or 3 different machines, just for simplicity we may use one)  

Simple Lab Hardware requirements: 16GB – 200 GB HDD/SSD
-	1 Workstation 2GB (maybe less)
-	1 Active Directory Server – 4GB (maybe less)
-	1 Linux Server with the monitoring tools – 4GB (you can have multiples linux server and start only one when you want to test a specific thing). 

### Use case
You need to setup your lab, install the OS’s for servers and workstations (Packer), setup active directory as well as join workstations to the AD (Ansible), you also need to install tools on those machines and create some configuration on them (Ansible), for example an agent to report events and traffic to your security operation server. This usually may take a few hours, but if you learn automation, you can setup labs very quickly.
I use WSL (Windows Subsystem for Linux) to take advantage of both worlds (Linux / Windows), because I didn’t use vagrant or terraform, I used bash scripting to combine all this.  
### Things to Learn
- [WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/install-win10) – Basically Linux running on your Windows 😊  
- [Packer](https://www.packer.io/) – Allows you to automate OS Installation. 
- [Ansible](https://www.ansible.com/) – To automate apps and IT infrastructure.
- [Terraform](https://www.terraform.io/) or [Vagrant](https://www.vagrantup.com/) – Because I use VMWare workstation, I didn’t learn about terraform or vagrant, in the case of vagrant, you need to buy a particular license and terraform was not clear to me when I started doing my automation, so I quit learning about that, but most of the time, you may need to understand terraform or vagrant for a fully automated experience. 

## Windows Events Collection
Windows generate some defaults events that can help you to detect threats, but there are others events you can activate or install.

You can enable others events from windows configuration and you can also install tools like Sysmon which provides detailed information about process creations, network connections, changes to files, etc.

It is also possible to use Windows ETW as demostrated with [SilkELK](https://github.com/fireeye/SilkETW) to collect more information from the host.

There may be other things you want to do, but those are the topics I covered during my journey. 

### Use Case 
You need to hunt for threats within your enviroment or use data for forencis analysis. Windows Events allow you to track actions and changes within a Windows endpoint. You can also use research from other blueteamers if you have the correct logs available on your systems.

### Things to Learn
- [Windows Events](https://docs.microsoft.com/en-us/windows/win32/events/windows-events)
- [Sysmon](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)

## Host & Network Monitoring
Before we can do threat hunting we need to collect information from different sources and centralize that information in one place. There are many tools you can use to monitor your workstations and network. I started the journey understanding how the ELK Stack (Elasticsearch, Logstash & Kibana) works, most of the tools out there use this stack and it makes sense to have an idea what it do behind the scene. 

### Use Case
You need to centralize your events and logs collection, you need your endpoints, servers, applications, switches and firewall to send their logs and events to one location. With all this information you can start building detections and identifying threats within your enviroment. 

There's an incident on your enviroment and there are some host that you suspect are compromised, you need to query the host on realtime to identify running threats, you can use OSQuery to do that. 

### Things To Learn
I'll mention some tools for you to try them and choose the one that you like the most or the conbination of some of them.

#### Events & Logs Collection
- [Winlogbeat](https://www.elastic.co/beats/winlogbeat)
- [Filebeats](https://www.elastic.co/beats/filebeat)
- Syslogs

#### Network monitoring / IDS
- [Zeek](https://zeek.org/)
- [Snort](https://www.snort.org/)
- [Suricata IDS](https://suricata-ids.org/)

#### Centralize Management
- ELK Stack (ElasticSearch, Kibana, Logstash)
- [Wazuh](https://wazuh.com/)
- [THE HELK](https://github.com/Cyb3rWard0g/HELK)
- [Security Onion](https://securityonionsolutions.com/)

### OS Realtime query
Query your devices like a database.
- [Osquery](https://osquery.io/)
- [Kolide](https://www.kolide.com/)
- [Fleet](https://github.com/kolide/fleet)

## Threat Hunting
Once with all data being collected in one location we can start doing our threat hunting. There are many methods we can use but we'll focus on some methods being develop by the BlueTeam Community. Will focus on Snort for network traffic, YARA for files and Sigma for logs. Those project aims to have generic rules which can be shared and run against different targets.

### Use Case 
A new threat came and you want to understand if you are vulernable or compromise, the community release a new sigma rule to detect that threat and you run it again your collected data. 

### Things to Learn
- [YARA](https://github.com/Yara-Rules/rules)
- [Sigma](https://github.com/Neo23x0/sigma)
- [Snort](https://www.snort.org/)
- [LogonTracer](https://github.com/JPCERTCC/LogonTracer)
- [PlumHound](https://github.com/PlumHound/PlumHound)
- [ivre](https://github.com/cea-sec/ivre)

## Vulnerability Management
In order to identify vulnerability on endpoints or services you can use a Vulnerability Management solution.

### Use Case
You have multiples endpoints and services on you enviroment, you need to make sure they are not vulnerable to public exploits or common vulnerabilities, you can scan those endpoints and services to identify those vulnerability and create an action plan to fix it. 

### Things to Learn
- [Wazuh](https://wazuh.com/)

## Threat Intelligence
A threat intelligence platform for gathering, sharing, storing and correlating Indicators of Compromise of targeted attacks, threat intelligence, financial fraud information, vulnerability information or even counter-terrorism information. (MIPS definition) 
 
### Use Case
I didn't fully implement MIPS or OpenCTI, but can be a really good thing to learn. 

### Things to Learn
- [MIPS](https://www.misp-project.org/)
- [OpenCTI](https://www.opencti.io/en/)
