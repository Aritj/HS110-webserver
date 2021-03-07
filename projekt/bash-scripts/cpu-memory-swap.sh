#!/bin/bash
#!/bin/sh
# Get IP in CIDR notation x.x.x.x/y
ip -o -f inet addr show | grep 'eth0' | awk '/scope global/ {print $4}' > ../python/data/server.txt

# Get memory
free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }' >> ../python/data/server.txt

# Get storage
df -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}' >> ../python/data/server.txt

# Get CPU
top -bn1 | grep load | awk '{printf "%.2f\n", $(NF-2)}' >> ../python/data/server.txt

# Get uptime
awk '{print int($1/3600)":"int(($1%3600)/60)":"int($1%60)}' /proc/uptime >> ../python/data/server.txt
