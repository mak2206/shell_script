#!/bin/bash

create_user() {
    local username=$1
    useradd -m "$username" || { echo "Error creating user '$username'. Aborting."; return 1; }
    passwd "$username"
    echo "Successfully created user '$username'."
    return 0
}

modify_user() {
    local username=$1
	local passwd=$2
    # Add logic for modifying user here
    read -p "Enter the Password." password
	
	echo "Modifying user '$username'."
	echo -e "$password\n$password" | sudo passwd "$username"
    
	echo "Successfully modified user '$username':"
}

delete_user() {
    local username=$1
    userdel -r "$username" || { echo "Error deleting user '$username'. Aborting."; return 1; }
    echo "Successfully deleted user '$username'."
    return 0
}

create_group() {
    local groupname=$1  || { echo "Error creating group '$groupname'. Aborting."; return 1; }
	sudo groupadd "$groupname"
	[[ $? -eq 0 ]] && echo "Successfully created group '$groupname'." || echo "Not created the group"		
}

modify_group(){
		
        echo "1. Add User to a group."
		echo "2. Remove user to a group."
	
		
		
		read choice

case $choice in
    1) 
	local groupname=$1
	read -p "Enter the username" username  
	sudo usermod -aG  "$groupname" "$username"
	;;
	
	2)
	local groupname=$1  || { echo "Error modifying the group '$groupname'. Aborting."; return 1; }
	read -p "Enter the username" username
	sudo gpasswd --delete "$username" "$groupname" 
	;;
	
	*)
        echo "Invalid choice. Please select a valid option."
        ;;


esac	
}

delete_group(){
	local groupname=$1
	sudo groupdel "$groupname" 
	[[ $? -eq 0 ]]  && echo "Successfully deleted group '$groupname'." || echo "Not able deleted the group"	
	return 0	
}		

validate() {
    if [ "$1" == "u" ]; then
        echo "User"
       
	   PS3="Select an operation: "
        operations=("Create User" "Modify User" "Delete User")
        select opt in "${operations[@]}"; do
            case $opt in
                "Create User")
                    read -p "Enter username to create: " new_username
                    create_user "$new_username"
                    break
                    ;;
                "Modify User")
                    read -p "Enter username to modify the password: " mod_username               
					modify_user "$mod_username"
                    break
                    ;;
                "Delete User")
                    read -p "Enter username to delete: " del_username
                    delete_user "$del_username"
                    break
                    ;;
                *) echo "Invalid option. Please select a valid operation.";;
            esac
        done
        exit 0
    elif [ "$1" == "g" ]; then
        echo "Group"
        exit 0
    elif [ -z "$1" ]; then
        echo "Inputs cannot be blank. Please try again!"
        exit 1
    else
        echo "Invalid input. Please enter 'u' for User or 'g' for Group."
        exit 1
    fi
}

#############################################################
### Validation Of Group ####################
validate() {
    if [ "$1" == "g" ]; then
        echo "Group"

PS3="Select an operation: "
        operations=("Create Group" "Modify Group" "Delete Group")
        select opt in "${operations[@]}"; do
            case $opt in
                "Create Group")
                    read -p "Enter group name to be create: " new_groupname
                    create_group "$new_groupname"
                    break
                    ;;
				
				"Modify Group")
                
				read -p "Enter Group Name to modify be modified: " mod_groupname        
					 if ! getent group "$groupname" >/dev/null ; then
						echo "Group exists. Modifying group." 
						modify_group "$mod_groupname"
                    else
							echo "Invalid group name!!!!"
					break
					fi
                    ;;
                
				"Delete Group")				
                    read -p "Enter groupname to be delete: " del_groupname
					if ! getent group "$groupname" >/dev/null ; then
						echo "Group exists. deleting group." 
						delete_group "$del_groupname"
					else
							echo "Invalid group name!!!!"
					break
					fi
                    ;;
                
				*) echo "Invalid option. Please select a valid operation.";;
            esac
        done
        exit 0
    elif [ "$1" == "g" ]; then
        echo "Group"
        exit 0
    elif [ -z "$1" ]; then
        echo "Inputs cannot be blank. Please try again!"
        exit 1
    else
        echo "Invalid input. Please enter 'u' for User or 'g' for Group."
        exit 1
    fi
}



read -p "Do you want to work on User/Group level(u/g): " ug
validate "$ug"

echo "Exiting..."
