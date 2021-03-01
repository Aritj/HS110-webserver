#!/bin/bash
#!/bin/sh
ip -o -f inet addr show | grep 'eth0' | awk '/scope global/ {print $4}' > ../python/data/server.txt
free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }' >> ../python/data/server.txt
df -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}' >> ../python/data/server.txt
top -bn1 | grep load | awk '{printf "%.2f\n", $(NF-2)}' >> ../python/data/server.txt
