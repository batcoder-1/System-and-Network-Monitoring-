#!/bin/bash
# this script is used for networking monitoring along with system monitoring
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
echo "Welcome $(whoami)"
error_check
if [ "$1" == '-s' ]
then
echo "System uptime is: $(uptime -p)"
error_check
echo "Number of users are: $(uptime | cut -d "," -f 2)"
error_check
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
