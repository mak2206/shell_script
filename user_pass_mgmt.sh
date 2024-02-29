#!/bin/bash

create_user() {
    local username=$1
    local password=$2
    useradd -m "$username" || { echo "Error creating user '$username'. Aborting."; return 1; }
    echo "$username:$password" | chpasswd
    echo "Successfully created user '$username'."
}

modify_user() {
    local username=$1
    local password=$2
	echo "$username"
    echo -e "$password\n$password" | sudo passwd "$username"
    echo "Successfully modified user '$username'."
}


delete_user() {
    local username=$1
    userdel -r "$username" || { echo "Error deleting user '$username'. Aborting."; return 1; }
    echo "Successfully deleted user '$username'."
}

# Main script logic
input="$1"

# Extracting username and password from input using awk
username=$(awk -F 'username=| ' '{print $2}' <<< "$input")
password=$(awk -F 'password=| ' '{print $3}' <<< "$input")



if [[ $input == *"--create_user"* ]]; then
    create_user "$username" "$password"
elif [[ $input == *"--modify_user"* ]]; then
    modify_user "$username" "$password"
elif [[ $input == *"--delete_user"* ]]; then
    delete_user "$username"
else
    echo "Invalid operation. Please use --create_user, --modify_user, or --delete_user."
fi
