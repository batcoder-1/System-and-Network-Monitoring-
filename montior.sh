#!/bin/bash
# this script is used for networking monitoring along with system monitoring
# os realted which is /etc/os-release file , battery related info , cpu realted info, 
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
echo "Welcome $(whoami)"
error_check
if [ "$1" == '-s' ]
then
print_star
print_line "System"
echo "System uptime is: $(uptime -p)"
error_check
echo "Number of users are: $(uptime | cut -d "," -f 2 | tr -d " " )"
error_check
cat /etc/os-release | grep "PRETTY_NAME" | echo Operating System : $(cut -d "=" -f 2 | tr -d " ")
error_check
lscpu | grep "Model name" | echo "CPU-Model-name: $(cut -d ":" -f 2 | tr -d " ")"

upower -v >> /dev/null
if [ $? != 0 ]
then
		print_star
		echo "Upower command not installed"
		sudo apt install uptime >> /dev/null # currently doing only for debian but we have to package manager of all other distro as well 
		echo "Installing upower command"
fi
print_star
#-------------------------------------------------------
print_line "Battery"
upower -b | grep "percentage" | echo "Battery Percentage: $(cut -d ":" -f 2 | tr -d " ")"
upower -b | grep "state" | echo "Current-state: $(cut -d ":" -f 2 | tr -d " ")"
upower -b | grep "temperature" | echo "Battery Temperature: $(cut -d ":" -f 2 | tr -d " ")"
upower -b | grep " charge-start-threshold" | echo "Charging-Threshold-start: $(cut -d ":" -f 2 | tr -d " ")"
upower -b | grep " charge-end-threshold" | echo "Charging-Threshold-end: $(cut -d ":" -f 2 | tr -d " ")"
upower -b | grep "charge-cycles" | echo "Number of charge cycles: $(cut -d ":" -f 2 | tr -d " ")"
upower -b | grep "time to empty" | echo "Time to empty: $(cut -d ":" -f 2 | tr -d " ")"
#------------------------------------------------------
elif [ "$1" == '-n' ]
then
	echo "networking monitoring"

#------------------------------------------------------
elif [ "$1" == '-h' ]
then 
	echo "help section"
#-------------------------------------------------------
else
	print_star
	echo "Please select  one option. Available options are:
	      1) -s for system monitoring 
	      2) -n for network monitoring
	      3) -h for help"
       	print_star
fi
