#!/bin/bash
# this script is used for networking monitoring along with system monitoring

error_check(){
if [ $? != 0 ]
then
        echo "=============================================="
        echo "Error occured kindly look the error logs for more information"
        echo "=============================================="
        exit 1
fi
}
echo "Welcome $(whoami)"
error_check
if [ "$1" = '-s' ]
then
echo "System uptime is: $(uptime -p)"
error_check
echo "Number of users are: $(uptime | cut -d "," -f 2)"
error_check
fi