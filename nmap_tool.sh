#!/bin/bash

file="./list.txt"
mkdir reports
PSR="\e[35m >> \e[92m"
DEF="\e[39m "
DEPENDENCIES=('toilet' 'nmap')

function is_installed() {
	II=$(which $1 |grep -c $1)
	echo "${II}"
}

function check_deps() {
  printf "${PSR} Checking dependencies.......... ${DEF}\n"
	for pkg in ${DEPENDENCIES[@]}; do
		i=$(is_installed $pkg)
		if [ ${i} != "1" ]; then
			printf "${PSRE} ${pkg} is not installed. Please install ${pkg} and run vpnroulette again${DEF}\n"
			exit 2
		else
			printf "${PSR} ${pkg} is installed ......OK${DEF}\n"
		fi
	done
}

function banner(){
        if [ $(is_installed toilet) != "1" ]; then
                echo "·-= NmapListScanner =-·  "
        else
                toilet --metal -f future "Nmap List Scanner"
        fi
        
}

function doWork(){
        while IFS= read -r line; do    
                printf "${PSR} Host: $line ${DEF}\n"
                nmap -v -n -T5 "$line" -sV -oX "./reports/$line".xml
        done < "$file"
}
check_deps
banner
doWork

echo "Done! Check the reports directory!"