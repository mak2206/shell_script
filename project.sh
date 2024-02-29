#!/bin/bash

# Directory paths
website_dir="/var/www/html/scoops"
backup_dir="/var/www/html_backup"
github_repo="https://github.com/Shoaib720/scoops"

# Perform git pull from private GitHub repo
cd $website_dir
sudo git pull $github_repo

# Create a backup of the current website
timestamp=$(date +"%m%d%Y")
backup_folder="$backup_dir/$timestamp"
sudo mkdir -p $backup_folder
sudo rsync -avr --exclude=".*/"  $website_dir $backup_folder

echo "Done"
echo "Starting with updating Apache Web Server"

# Deploy the updated website to Apache Web Server using SSH

sudo sshpass -f   /home/neosoft/Desktop/neo/myfile scp -rv -P 1024 [!.]* $website_dir/* root@localhost:/var/www/html/ 
