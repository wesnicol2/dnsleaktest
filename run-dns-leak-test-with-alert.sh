#!/bin/bash
log_dir="log"
mkdir -p $log_dir
verbose_log="$log_dir/verbose-dns-leak-test-with-alert.log"  # Verbose log file
dns_leak_log="$log_dir/dns-leak-test-with-alert.log"  # DNS leak log file

touch $verbose_log
touch $dns_leak_log

new_execution_log_line="\n\nNEW EXECUTION ========== $(date +%Y-%m-%d\ %H:%M:%S) ========== NEW EXECUTION"
echo -e "$new_execution_log_line" >> $verbose_log
echo -e "$new_execution_log_line" >> $dns_leak_log

while :
do
    echo -e "\n\n========== $(date +%Y-%m-%d\ %H:%M:%S) ==========" >> "$verbose_log"

    output=$(python dnsleaktest-with-alert.py 2>&1)  # Run the Python script and capture its output
    echo "$output" >> "$verbose_log"  # Write all output to the verbose log

    if echo "$output" | grep -q "DNS may be leaking."; then
        echo "DNS leak detected at $(date +%Y-%m-%d\ %H:%M:%S)" >> "$dns_leak_log"
    fi
    
    sleep 1  # Add a delay before running the program again
done
