#!/bin/bash

# Function to list files and directories in a specific format
list_files() {
    echo "Listing files and directories in the specified format:"
    ls -lh
}

# Function to search for files based on criteria
search_files() {
    read -p "Enter the search criteria (name, type, size): " criteria
    case $criteria in
        name)
            read -p "Enter the file name: " file_name
            echo "Searching for files with name $file_name in $dir_path path:"
            sudo find "$dir_path" -type f -iname "$file_name"*
            ;;
        type)
            read -p "Enter the file type (e.g., txt, pdf): " file_type
            echo "Searching for files of type $file_type:"
            find . -type f -name "*.$file_type"
            ;;
        size)
            read -p "Enter the file size (in KB): " file_size
            echo "Searching for files with size greater than $file_size KB:"
            find . -type f -size +${file_size}k
            ;;
        *)
            echo "Invalid search criteria."
            ;;
    esac
}

# Function to copy, move, or delete files/directories based on conditions
manage_files() {
    read -p "Enter the operation to perform (copy, move, delete): " operation
    case $operation in
        copy)
            read -p "Enter the file/directory to copy: " source
            read -p "Enter the destination directory: " destination
            cp -r "$source" "$destination"
            ;;
        move)
            read -p "Enter the file/directory to move: " source
            read -p "Enter the destination directory: " destination
            mv "$source" "$destination"
            ;;
        delete)
            read -p "Enter the file/directory to delete: " target
            rm -r "$target"
            ;;
        *)
            echo "Invalid operation."
            ;;
    esac
}

# Main script

echo "--- Task Automation Script ---"
read -p "Please provide the directory path to search: " dir_path

# Error handling using try-except blocks
if [ ! -d "$dir_path" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

cd "$dir_path"

# Menu for user input and task selection
echo "--- Task Selection ---"
echo "1. List files and directories"
echo "2. Search for files"
echo "3. Manage files (copy, move, delete)"
read -p "Select a task (1-3): " choice

case $choice in
    1)
        list_files
        ;;
    2)
        search_files
        ;;
    3)
        manage_files
        ;;
    *)
        echo "Invalid choice."
        ;;
esac

