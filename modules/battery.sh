#!/bin/bash
#Script for battery information
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
print_star
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
	echo "Health: $(cat $battery_info_path/$i/health)";
	echo "Status: $(cat $battery_info_path/$i/status)";
	echo "Charge_Start_Threshold: $(cat $battery_info_path/$i/charge_control_start_threshold)";
	echo "Charge_End_Threshold: $(cat $battery_info_path/$i/charge_control_end_threshold)";
	echo "Cycles_Completed: $(cat $battery_info_path/$i/cycle_count)";
	echo "--------------------------------------------------"
done
print_star
#------------------------------------------------------