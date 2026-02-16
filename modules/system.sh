#---------------------------------------------------------------
#functions
print_star(){
         echo "================================================"
}
error_check(){
if [ $? != 0 ]
then
        print_star
        echo "Error occured kindly look the error logs for more information"
	print_star
        exit 1
fi
}
print_line(){
	echo "$1 section" 
	print_star
}
#-------------------------------------------------------
print_star
print_line "System"
echo "Kernel Version: $(uname -r)"
echo "System Uptime: $(uptime -p)"

USERS=$(uptime | cut -d "," -f 2 | xargs)
echo "Active Users: $USERS"

OS=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')
echo "Operating System: $OS"

CPU=$(lscpu | grep "Model name" | cut -d: -f2 | xargs)
echo "CPU Model: $CPU"

ARCH=$(lscpu | grep -i "architecture" | cut -d: -f2 | xargs)
echo "Architecture: $ARCH"

echo "CPU Cores: $(nproc)"

MEM=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
echo "Memory Usage: $MEM"

echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"

print_star
#---------------------------------------------------------