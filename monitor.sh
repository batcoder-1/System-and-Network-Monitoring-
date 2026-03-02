#!/bin/bash
# this script is used for networking monitoring along with system monitoring
# os realted which is /etc/os-release file , battery related info , cpu realted info, 
#---------------------------------------------------------------
#variables
# battery_info_path=/sys/class/power_supply
# batteries=$(ls $battery_info_path | grep -i "bat")

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
run_script(){
	"$(dirname "$0")"/$1
}
#-------------------------------------------------------
echo "WELCOME $(whoami)"
error_check
if [ "$1" == '-s' ]
then
	run_script modules/system.sh
#-------------------------------------------------------
elif [ "$1" == "-b" ]
then
	run_script modules/battery.sh
#------------------------------------------------------
elif [ "$1" == '-n' ]
then
	run_script modules/networking.sh
#------------------------------------------------------
elif [ "$1" == '-h' ]
then 
	run_script modules/help.sh
#-------------------------------------------------------
else
	print_star
	echo "Please select  one option. Available options are:
	      1) -s for system monitoring 
	      2) -n for network monitoring
	      3) -h for help"
       	print_star
fi
