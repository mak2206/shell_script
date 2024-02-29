#!/bin/bash

# Display menu options
echo "Choose an option:"
echo "1. Navigate to a specific directory"
echo "2. Print current working directory"
echo "3. List files and directories in the current directory"
echo "4. Create a directory"
echo "5. Delete a directory"
echo "6. Rename a directory"
echo "7. Move a files/directory"

read choice

case $choice in
    1)
# Ask the user for a directory path
echo "Enter the directory path:"
read directory_path

# Check if the directory exists
if [[ ! -d "${directory_path}" ]]; then
    echo "Error: Directory not found." >&2
    exit 1
fi

# Change to the given directory
cd "$directory_path" || exit 1
	  # Successful move verification
[[ $? -eq 0 ]] && echo "You are in $(pwd)" || echo "Not moved"
  
 ;;
    2)
        # Print current working directory
        echo "Current directory:"
        pwd
        ;;
    3)
        # List files and directories in the current directory
        echo "Contents of the current directory:"
        ls -la
        ;;

    4)
		# Create a directory
		echo "Enter a directory name:"
		read directory_path

		# Check if the directory already exists
		if [[ -d "${directory_path}" ]]; then
			echo "Directory already exist."
		else
			mkdir -p "$directory_path"
			if [[ $? -eq 0 ]]; then
				echo "Directory has been created $(directory_path)"
			else
				echo "Error: Couldn't create directory."
			fi
		fi

        ;;

    5)
        # Remove directory
        echo "Enter the path to delete the directory:"
        read directory_path
        
        # Check if the directory exists
        if [[ ! -d "${directory_path}" ]]; then
            echo "Error: Directory not found." >&2
            continue
        fi
        
        rmdir "$directory_path" || { echo "Error: Couldn't remove directory."; exit 1; }
        ;;

    6)
        # Rename directory
        echo "Enter the path of directory to be rename:"
        read old_directory_path
        
        # Check if the directory exists
        if [[ ! -d "${old_directory_path}" ]]; then
            echo "Error: Directory not found." >&2
            continue
        fi
        
        echo "Enter the path of directory to be renamed:"
        read new_directory_path
        
        # Avoid unnecessary moves if the source and destination directories are the same
        if [[ ${old_directory_path} == ${new_directory_path} ]]; then
            echo "Error: New directory path must differ from old one." >&2
            continue
        fi
        
        mv "$old_directory_path" "$new_directory_path" || { echo "Error: Couldn't rename directory."; exit 1; }
        ;;

    7)
		# Prompt user for source and destination
		read -p "Move a file or directory - Enter source: " src
		read -p "Enter destination: " dst

		# Validate source and destination
		if [[ ! -e "$src" ]]; then
			echo "Source file/directory not found."
		elif [[ -e "$dst" ]]; then
			   mv "$src" "$dst" 
			   
			  # Successful move verification
		[[ $? -eq 0 ]] && echo "File moved successfully!" || echo "Failed to move file."
		 
		fi  
      ;;
		
    *)
        echo "Invalid choice. Please select a valid option."
        ;;
esac
