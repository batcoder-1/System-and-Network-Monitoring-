        # this primarily consist of netcheck + netinfo + ports and address info 
        #network.sh
        #       -> netcheck()
        #       -> netinfo()
        #       -> netports()
        # # netcheck logic:
        # 1. detect active interface
        # 2. verify IP
        # 3. check default route
        # 4. test connectivity
        # 5. test DNS

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
        check_ip4(){
                ip addr show $1 | grep "inet" | grep -v "inet6" >> /dev/null
                return $?;
        }
        netcheck(){
                Number_of_interface=$(ls /sys/class/net | wc -l);
                echo "Number of network interfaces available: $Number_of_interface"
                interfaces=$(ls /sys/class/net);
                for interface in $interfaces;
                        do kernel_interface_status=$(cat /sys/class/net/$interface/operstate);
                           physical_interface_status=$(cat /sys/class/net/$interface/carrier);
                           if [ $kernel_interface_status == "up" ] && [ $physical_interface_status == "1" ]
                                then echo "Interface $interface:link-ready to use";
                                check_ip4 $interface
                                if [ $? -eq 0 ]
                                        then echo "Interface $interface is ip configured"
                                else
                                        echo "Interface $interface is not ip configured"
                                fi
                           else
                                echo "Interface $interface: not link-ready"
                           fi
                        done;
                        
        }
        #-------------------------------------------------------
        print_line Networking
        netcheck 
        print_star
        #-------------------------------------------------------