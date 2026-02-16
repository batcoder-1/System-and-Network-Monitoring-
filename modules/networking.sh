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
print_line Networking
echo "Netoworking Section"
print_star
#-------------------------------------------------------