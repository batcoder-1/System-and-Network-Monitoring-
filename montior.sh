#!/bin/bash
# this script is used for networking monitoring along with system monitoring
# os realted which is /etc/os-release file , battery related info , cpu realted info, 
#---------------------------------------------------------------
#variables
battery_info_path=/sys/class/power_supply
batteries=$(ls $battery_info_path | grep -i "bat")

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
echo "WELCOME $(whoami)"
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
#-------------------------------------------------------
print_line "Battery"
echo "Number of Batteries: $(echo $batteries | wc -l)";
for i in $batteries;
do 
	echo "-------------------------------------------------"
	echo "$i: "
	echo "Model: $(cat $battery_info_path/$i/model_name)";
	echo "Manufacturer: $(cat $battery_info_path/$i/manufacturer)";
	echo "Serial_Number: $(cat $battery_info_path/$i/serial_number)";
	echo "percentage: $(cat $battery_info_path/$i/capacity)";
	echo "Status: $(cat $battery_info_path/$i/status)";
	echo "Health: $(cat $battery_info_path/$i/health)";
	echo "Status: $(cat $battery_info_path/$i/status)";
	echo "Charge_Start_Threshold: $(cat $battery_info_path/$i/charge_control_start_threshold)";
	echo "Charge_End_Threshold: $(cat $battery_info_path/$i/charge_control_end_threshold)";
	echo "Cycles_Completed: $(cat $battery_info_path/$i/cycle_count)";
	echo "--------------------------------------------------"
done
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
