#!/bin/bash
verbose_log="verbose-dns-leak-test.log"  # Verbose log file
dns_leak_log="dns-leak-test.log"  # DNS leak log file

touch $verbose_log
touch $dns_leak_log
while :
do
    echo -e "\n\n========== $(date +%Y-%m-%d\ %H:%M:%S) ==========" >> "$verbose_log"

    output=$(python dnsleaktest.py 2>&1)  # Run the Python script and capture its output
    echo "$output" >> "$verbose_log"  # Write all output to the verbose log

    if echo "$output" | grep -q "DNS may be leaking."; then
        echo "DNS leak detected at $(date +%Y-%m-%d\ %H:%M:%S)" >> "$dns_leak_log"
    fi
    
    sleep 1  # Add a delay before running the program again
done
