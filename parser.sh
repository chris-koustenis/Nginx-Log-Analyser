#!/bin/bash

# Example log line:
# 142.93.136.176 - - [04/Oct/2024:00:00:22 +0000] "GET /v1-health HTTP/1.1" 200 51 "-" "DigitalOcean Uptime Probe 0.22.0 (https://digitalocean.com)"
input_file=$1
if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_file>\n No arguments supplied"
    exit 1
fi
if [ $1 == "--help" ] || [ $1 == "-h" ]; then
    echo "Usage: $0 <log_file>\n Parses the given log file and provides statistics on IP addresses, requested paths, response status codes, and user agents."
    exit 0
fi
if [ -e /path/to/your/file ]; then
    echo "File exists."
else
    echo "File does not exist."
    exit 1
fi


# 1.Top 5 IP addresses with the most requests:"
awk '{print $1}' "$input_file" | sort | uniq -c | sort -r | head -n 5 \
    | awk '{print $2 " - " $1 " requests"}'
echo "=============================================="
# 2. Top 5 most requested paths
echo "Top 5 most requested paths:"
awk '{print $7}' "$input_file" | sort | uniq -c | sort -r | head -n 5 \
    | awk '{print $2 " - " $1 " requests"}'
echo "=============================================="
# 3. Top 5 response status codes
echo "Top 5 response status codes:"
awk -F '" ' '{split($2, code, " "); print code[1]}' "$input_file" | sort | uniq -c | sort -r | head -n 5 \
    | awk '{print $2 " - " $1 " requests"}'
echo "=============================================="
# 4. Top 5 user agents
echo "Top 5 user agents:"
awk -F'"' '{print $6}' "$input_file" | sort | uniq -c | sort -r | head -n 5 \
    | awk '{print $2 " - " $1 " requests"}'
