#!/bin/bash
#!/bin/sh


# Check 'config' file for subnet specification, save to variable 'network_info'
network_config=$(cat ../config | grep subnet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/2[0-9]')

if [[ -z "$network_config" ]]; then
  # If network config is not OK
  # get LAN information on 'eth0' in CIDR notation
  # save to variable 'network_info'.
  network_info=$(ip -o -f inet addr show | grep 'eth0' | awk '/scope global/ {print $4}')
else
  # If network config is OK
  # use that subnet.
  network_info=$network_config
fi

# Aggressively scan LAN network for port TCP/9999
# Grep for devices with port TCP/9999 open
# Grep for IP addresses of devices with port TCP/9999 open
echo "$network_info" > ../python/data/ip.txt
nmap -Pn -p 9999 $network_info | grep -B4 "open" | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' >> ../python/data/ip.txt
