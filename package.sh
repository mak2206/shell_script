#!/bin/bash

echo "Enter the package name"
read package

# Display menu options
echo "Choose an option:"
echo "1. Search the package."
echo "2. Install the package."
echo "3. Update the packages."
echo "4. Remove the package."


read choice

case $choice in
    1)
	
	sudo apt search $package
	;;

	2) 
	
	sudo apt install $package
	;;
	
	3)

	sudo apt-get  update  --dry-run 
	;;

	4) 
	
	sudo apt remove $package
	;;
	
    *)
        echo "Invalid choice. Please select a valid option."	
	
esac
	