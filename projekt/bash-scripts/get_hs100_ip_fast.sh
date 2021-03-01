#!/bin/sh
# Group 5

# Get network information (IP address and subnet mask in CIDR notation)
# Save to variable 'network_info', this variable will be used in the NMAP command.
network_info=$(ip -o -f inet addr show | grep 'eth0' | awk '/scope global/ {print $4}')

# Aggresively scan LAN network for port TCP/9999
# Grep for devices with port TCP/9999 open
# Grep for IP addresses of devices with port TCP/9999 open
nmap -T5 -Pn -p 9999 $network_info | grep -B4 "open" | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' > '/home/atj/projekt/python/data/ip.txt'
