#!/bin/bash

function create_user {
    local username=$1
    local password=$2
    if ! id -u "$username" > /dev/null 2>&1; then
        useradd -m "$username" && echo "$username:$password" | chpasswd
    else
        echo "Error creating user '$username'. Aborting."
    fi
}

function modify_user {
    local username=$1
    local password=$2
    if id -u "$username" > /dev/null 2>&1; then
        echo "$username"
        echo -e "$password\n$password" | sudo passwd "$username"
        echo "Successfully modified user '$username'."
    else
        echo "Error modifying user '$username'. User does not exist."
    fi
}

function delete_user {
    local username=$1
    if id -u "$username" > /dev/null 2>&1; then
        userdel -r "$username" && echo "Successfully deleted user '$username'."
    else
        echo "Error deleting user '$username'. User does not exist."
    fi
}

main () {
    case "$1" in
        "--create_user")
            create_user "$2" "$3"
            ;;
        "--modify_user")
            modify_user "$2" "$3"
            ;;
        "--delete_user")
            delete_user "$2"
            ;;
        *)
            echo "Invalid operation. Please use --create_user, --modify_user, or --delete_user."
            ;;
    esac
}

main "$@"
