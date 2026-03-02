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
        # # netinfo 
        # 1. default route interface info
        #    a. name and ip 
        #    b. gateway 
        #    c. DNS servers
        #    d. MAC address
        #    e. MTU and other important details
        # # netports
        # 1. Only listening tcp and upd ports 
        #       a. another flag for all ports
        #       b. flag for all the ports as well  
        #--------------------------------------------------------------
        #variables
          route_interface=$(ip route | grep "default" | cut -d " " -f 5);
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
        ip_connection_check(){
                ping -c 1 8.8.8.8 > /dev/null
                return $?
        }
        dns_check(){
                ping -c 1 www.google.com > /dev/null
                return $?
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
                                        if [ $route_interface == $interface ]
                                                then echo "$interface is set as default route"
                                        fi
                                else
                                        echo "Interface $interface is not ip configured" 
                                fi
                           else
                                echo "Interface $interface: not link-ready"
                           fi
                        done;
                ip_connection_check 
                if [ $? -eq 0 ]
                        then echo "Interface $route_interface is connected to internet"
                else
                        echo "Interface $route_interface is not connected to internet"
                fi
                dns_check
                if [ $? -eq 0 ]
                        then echo "DNS is configured"
                else
                        echo "DNS is not configured or it has some error"
                fi
        }
        netinfo(){
                echo "=============Network Information================"
                echo " "
                echo "Default route interface: $route_interface"
                ip_route_interface=$(ip addr show $route_interface | grep "inet" | grep -v "inet6" | awk '{print $2'});
                gateway_interface=$(ip route | grep "default" | grep "via" | awk '{print $3}')
                dns_servers=$(cat /etc/resolv.conf | grep "nameserver")
                echo "IPv4 of route interface $route_interface: $ip_route_interface"
                echo "Default Gateway is: $gateway_interface"
                echo "DNS Servers:"
                echo "$dns_servers" | sed 's/^/  /'
                echo ""
                mac_address=$(ip link show $route_interface | grep "link/ether" | awk '{print $2}')
                echo "MAC Address: $mac_address"
                mtu=$(ip link show $route_interface | grep "mtu" | awk '{print $5}')
                echo "MTU: $mtu"
        }
        netports(){
                echo "=============Listening Ports================"
                echo " "
                echo "All open tcp ports are: "
                ss -H -ltup | column -t
        }
        #-------------------------------------------------------
        print_line Networking
        netcheck 
        print_star
        netinfo
        print_star
        netports
        print_star
        #-------------------------------------------------------