# NetDiag - System and Network Monitoring

NetDiag is a Bash-based monitoring toolkit for Linux systems. It provides quick diagnostics for:
- System information
- Battery details
- Network health and connectivity
- Open/listening network ports

The project entrypoint is `monitor.sh`, which calls module scripts in `modules/`.

## Project Structure

```text
.
├── monitor.sh
├── Readme.md
└── modules
		├── system.sh
		├── battery.sh
		├── networking.sh
		└── help.sh
```

## Features

### 1) System Monitoring (`-s`)
- Kernel version
- Uptime
- Active users
- OS name
- CPU model, architecture, core count
- Memory usage
- Load average

### 2) Battery Monitoring (`-b`)
- Number of batteries
- Model, manufacturer, serial number
- Capacity, health, status
- Temperature (converted to Celsius)
- Charge start/end thresholds
- Cycle count

### 3) Networking Monitoring (`-n`)
- Interface link readiness
- IPv4 configuration check
- Default route check
- Internet connectivity check (`8.8.8.8`)
- DNS resolution check (`www.google.com`)
- Route interface details: IPv4, gateway, DNS, MAC, MTU
- Listening TCP/UDP ports (`ss`)

### 4) Help (`-h`)
- Displays CLI options, module coverage, and setup guidance.

## Requirements

- Linux OS
- Bash
- Common utilities used by modules:
	- `ip`
	- `ss`
	- `ping`
	- `lscpu`
	- `free`
	- `awk`, `grep`, `cut`, `sed`, `column`

> Note: Battery module expects battery data in `/sys/class/power_supply/BAT*`. On desktops or systems without batteries, some values may be unavailable.

## Usage

From project directory:

```bash
chmod +x monitor.sh modules/*.sh
./monitor.sh -s
./monitor.sh -b
./monitor.sh -n
./monitor.sh -h
```

## Run from Any Directory (`netdiag`)

By default, users run the script via project path. To avoid that, create a global symbolic link.

```bash
sudo chmod +x /home/naman/Devops/System-and-Network-Monitoring-/monitor.sh
sudo ln -sf /home/naman/Devops/System-and-Network-Monitoring-/monitor.sh /usr/local/bin/netdiag
```

Then run from anywhere:

```bash
netdiag -s
netdiag -b
netdiag -n
netdiag -h
```

`sudo` is required because `/usr/local/bin` is a system-owned path.

## Notes

- `monitor.sh` supports symlink-safe execution and resolves module paths reliably.
- Current CLI supports one option at a time: `-s`, `-b`, `-n`, or `-h`.

