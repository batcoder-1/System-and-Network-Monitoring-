#!/bin/bash

print_star(){
    echo "================================================"
}

cat << 'EOF'
================================================
        SYSTEM AND NETWORK MONITORING HELP
================================================

USAGE
    ./monitor.sh [OPTION]

OPTIONS
    -s    Run system monitoring
    -b    Run battery monitoring
    -n    Run networking monitoring
    -h    Show this help message

MODULES
    1) system.sh
       - Kernel version
       - System uptime
       - Active users
       - Operating system
       - CPU model, architecture, cores
       - Memory usage
       - Load average

    2) battery.sh
       - Number of batteries
       - Model, manufacturer, serial number
       - Capacity percentage
       - Health and status
       - Temperature
       - Charge thresholds
       - Cycle count

    3) networking.sh
       - Interface/link readiness check
       - IPv4/default route verification
       - Internet and DNS check
       - Route interface, gateway, DNS, MAC, MTU
       - Listening TCP/UDP ports

EXAMPLES
    ./monitor.sh -s
    ./monitor.sh -b
    ./monitor.sh -n
    ./monitor.sh -h

NOTES
    - Some modules require Linux tools like: ip, ss, ping, lscpu, free.

RUN FROM ANY DIRECTORY (PROJECT COMMAND: netdiag)
    By default, run from project directory:
        ./monitor.sh -s

    Create a global symbolic link (requires root privileges):
        sudo chmod +x /home/naman/Devops/System-and-Network-Monitoring-/monitor.sh
        sudo ln -sf /home/naman/Devops/System-and-Network-Monitoring-/monitor.sh /usr/local/bin/netdiag

    Then run from any working directory:
        netdiag -s
        netdiag -b
        netdiag -n
        netdiag -h

================================================
EOF  