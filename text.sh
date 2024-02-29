#!/bin/bash

# Display menu options
echo "Choose an option:"
echo "1. Search using "grep" command."
echo "2. Find disk space of a directory using "awk" command."
echo "3. Search and replace using "sed" command."

read choice

case $choice in
    1)
echo "Enter the word which needs to be searched in files"
read word

echo "Enter the path in which the word needs to be searched"
read dir

# Check if the directory exists
if [[ ! -d "${dir}" ]]; then
    echo "Error: Directory not found." >&2
    exit 1
fi

egrep -ri "$word" "$dir" 
;;

	2)
	echo "Enter the file location to calculate the size"
	read dir
	
# Check if the directory exists
if [[ ! -d "${dir}" ]]; then
    echo "Error: Directory not found." >&2
    exit 1
fi
	
	ls -l $dir > $dir/$dir.txt
	echo "The Total disk size of "$dir" is $(awk -F ' ' '{sum+=$5;} END{print sum;}'  "$dir/$dir.txt" )"
	;;
	
	3)
echo "Enter the path in which the word needs to be searched"
read dir

if [[ ! -f "${dir}" ]]; then
    echo "Error: File not found." >&2
    exit 1
fi

echo "Enter the word which needs to be searched in files"
read word

echo "Enter the word which needs to be replaced in files"
read replace

# Check if the word has already been replaced in the file
if grep -ie "$replace" "$dir"; then
    echo "The word '$replace' has already been replaced in the file."
else
    sed -i "s/$word/$replace/g" "$dir"
    if [[ $? -eq 0 ]]; then
        echo "Replaced the word '$word' with '$replace' successfully!"
    else
        echo "Failed to replace."
    fi
fi
;;

esac
