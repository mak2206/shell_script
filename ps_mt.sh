#!/bin/bash

# Display menu options
echo "Choose an option:"
echo "1. List running processes"
echo "2. Start a service"
echo "3. Stop a service"
echo "4. Check status of service"
echo "5. Monitor process status"

read -p "Enter your choice: " choice

case $choice in
    1)
        ps -eo pid,command --sort=-cpu | head -n 15
        ;;
		
    2)
			START_PROCESS() {
    if [[ $# -eq 1 ]]; then
        service=$1
        if systemctl is-active --quiet "$service"; then
            echo "Process '$service' is already running."
        elif systemctl start "$service"; then
            echo "Started the '$service'"
        else
            echo "Failed to start '$service'."
        fi
    else
        echo "Usage: $(basename $0) <service>"
        exit 1
    fi
}
	read -p "Enter service name: " service_name
	START_PROCESS "$service_name"
        ;;
	
	3)
		STOP_PROCESS() {
    if [[ $# -eq 1 ]]; then
        service=$1
        if systemctl is-active --quiet "$service"; then
            systemctl stop "$service"; 
            echo "Stopped the '$service'"
        else
            echo "Failed to stop or already Stopped '$service'."
        fi
    else
        echo "Usage: $(basename $0) <service>"
        exit 1
    fi
	}
	read -p "Enter service name: " service_name
	STOP_PROCESS "$service_name"
        ;;
	
	4)
	read -p "Enter service name: " service_name
	systemctl status "$service_name"
	;;
	
    5)
        top
        ;;
    *)
        echo "Invalid choice. Please select a valid option."
        ;;
esac
