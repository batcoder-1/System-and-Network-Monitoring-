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
echo "System uptime is: $(uptime -p)"
error_check
echo "Number of users are: $(uptime | cut -d "," -f 2 | tr -d " " )"
error_check
cat /etc/os-release | grep "PRETTY_NAME" | echo Operating System : $(cut -d "=" -f 2 | tr -d " ")
error_check
lscpu | grep "Model name" | echo "CPU-Model-name: $(cut -d ":" -f 2 | tr -d " ")"
print_star  
#---------------------------------------------------------