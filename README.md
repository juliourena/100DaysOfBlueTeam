# 100 Days Of BlueTeam

### Work in progress.. I'm still updating this post. 

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
- WSL (Windows Subsystem for Linux) – Basically Linux running on your Windows 😊  
- Packer – Allows you to automate OS Installation. 
- Ansible – To automate apps and IT infrastructure.
- Terraform or Vagrant – Because I use VMWare workstation, I didn’t learn about terraform or vagrant, in the case of vagrant, you need to buy a particular license and terraform was not clear to me when I started doing my automation, so I quit learning about that, but most of the time, you may need to understand terraform or vagrant for a fully automated experience. 

## Windows Events Collection
Windows generate some defaults events that can help you to detect threats, but there are others events you can activate or install.

You can enable others events from windows configuration and you can also install tools like Sysmon which provides detailed information about process creations, network connections, changes to files, etc.

It is also possible to use Windows ETW as demostrated with [SilkELK](https://github.com/fireeye/SilkETW) to collect more information from the host.

There may be other things you want to do, but those are the topics I covered during my journey. 

### Use Case 
You need to hunt for threats within your enviroment or use data for forencis analysis. Windows Events allow you to track actions and changes within a Windows endpoint. You can also use research from other blueteamers if you have the correct logs available on your systems.

### Things to Learn
- Windows Events
- Sysmon

## Host & Network Monitoring
Before we can do threat hunting we need to collect information from different sources and centralize that information in one place. There are many tools you can use to monitor your workstations and network. I started the journey understanding how the ELK Stack (Elasticsearch, Logstash & Kibana) works, most of the tools out there use this stack and it makes sense to have an idea what it do behind the scene. 

### Use Case
You need to centralize your events and logs collection, you need your endpoints, servers, applications, switches and firewall to send their logs and events to one location. With all this information you can start building detections and identifying threats within your enviroment. 

There's an incident on your enviroment and there are some host that you suspect are compromised, you need to query the host on realtime to identify running threats, you can use OSQuery to do that. 

### Things To Learn
I'll mention some tools for you to try them and choose the one that you like the most or the conbination of some of them.

#### Events & Logs Collection
- Winlogbeats
- Filebeats
- Syslogs

#### Network monitoring / IDS
- Zeek 
- Snort
- Suricata IDS

#### Centralize Management
- ELK Stack (ElasticSearch, Kibana, Logstash)
- Wazuh
- THE HELK
- Security Onion

### OS Realtime query
Query your devices like a database.
- Osquery
- Kolide
- Fleet

## Threat Hunting
Once with all data being collected in one location we can start doing our threat hunting. There are many methods we can use but we'll focus on some methods being develop by the BlueTeam Community. Will focus on Snort for network traffic, YARA for files and Sigma for logs. Those project aims to have generic rules which can be shared and run against different targets.

### Use Case 
A new threat came and you want to understand if you are vulernable or compromise, the community release a new sigma rule to detect that threat and you run it again your collected data. 

### Things to Learn
- YARA
- Sigma
- Snort
- LogonTracer
- PlumHound
- ivre

## Vulnerability Management

### Use Case

### Things to Learn
- Wazuh

## Threat Intelligence

### Use Case

### Things to Learn
- MIPS
- OpenCTI
