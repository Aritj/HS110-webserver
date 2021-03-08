#!/bin/bash
#!/bin/sh

# Get network information (IP address and subnet mask in CIDR notation).
# Look into the 'config' file for subnet specification, save to variable 'network_info', whic will be used in the NMAP scan.
network_config=$(cat ../config | grep subnet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/2[0-9]')

if [[ -z "$network_config" ]]; then
  # If network config is not OK, then get LAN information on 'eth0' and save to variable 'network_info', this subnet will be used in the NMAP command.
  network_info=$(ip -o -f inet addr show | grep 'eth0' | awk '/scope global/ {print $4}')
else
  # If network config is OK, then use that subnet for NMAP command.
  network_info=$network_config
fi

# Aggresively scan LAN network for port TCP/9999
# Grep for devices with port TCP/9999 open
# Grep for IP addresses of devices with port TCP/9999 open
echo "$network_info" > ../python/data/ip.txt
nmap -Pn -p 9999 $network_info | grep -B4 "open" | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' >> ../python/data/ip.txt
