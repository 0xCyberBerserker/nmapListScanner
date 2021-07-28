#!/bin/bash

file="./list.txt"


while IFS= read -r line; do    
        echo '-> Host: '$line
        nmap -v -n -T5 "$line" -sV -oX "$line".xml
done < "$file"