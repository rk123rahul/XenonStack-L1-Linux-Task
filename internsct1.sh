#! /bin/bash	



help() {
   echo "Custom linux command"
   echo "Command name : internsctl"
   echo "Command version : v0.1.0"
   echo
   echo "options:"
   echo "cpu getinfo   get cpu information of the server."
   echo "memory getinfo   get memory information of the server."
   echo "-h|--help     Print this Help."
   echo "-V|--version  Print software version and exit."
   echo
}

version() {
echo "v0.1.0"
}

userList() {
cat /etc/passwd
}

sudoUser(){
members sudo
}

#memory information
getMemoryInfo(){
free
}


#cpu information
getCpuInfo(){
lscpu
}

#Takes the argument and get cpu information
if [[ "$@" == "cpu getinfo" ]]
then
	getCpuInfo
#Takes the argument and get memory information
elif [[ "$@" == "memory getinfo" ]]
then
	getMemoryInfo

elif [[ "$@" == "user list" ]]
then
	userList
	
elif [[ "$@" == "user list --sudo-only" ]]
then
	sudoUser

fi

#create a user in server
if [[ "$1" == "user" && "$2" == "create" ]]
then
	sudo useradd $3
 	echo "User with username $3 is created"
fi

#For the version and help
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do 
	case $1 in
  	  -V | --version ) version
			    exit
    			    ;;
  	  -h | --help ) help
    			exit
    			;;
    	esac;
done


#Advance level

#get file information 
if [[ "$1" == "file" && "$2" == "getinfo" && "$3" != "--size" && "$3" != "--permissions" && "$3" != "--owner" && "$3" != "--last-modified" && "$3" != "-s" && "$3" != "-p" && "$3" != "o" && "$3" != "m" ]]
then
    a=$(ls -l $3)
    b=($a)
    echo "File: ${b[8]}"
    echo "Access: ${b[0]}"
    echo "Size: ${b[4]}"
    echo "Owner: ${b[3]}"
    echo "Modify: ${b[5]} ${b[6]} ${b[7]}"


fi


#file getinfo option

if [[ "$1" == "file" && "$2" == "getinfo" && "$3" == "--size" || "$3" == "-s" ]]
then
        x=$(ls -l $4)
        y=($x)
        echo ${y[4]}

elif [[ "$1" == "file" && "$2" == "getinfo" && "$3" == "--permissions" || "$3" == "-p" ]]
then
	x=$(ls -l $4)
        y=($x)
	echo ${y[0]}

elif [[ "$1" == "file" && "$2" == "getinfo" && "$3" == "--owner" || "$3" == "o" ]]
then
	x=$(ls -l $4)
        y=($x)
	echo ${y[3]}
elif [[ "$1" == "file" && "$2" == "getinfo" && "$3" == "--last-modified" || "$3" == "m" ]]
then
	x=$(ls -l $4)
        y=($x)
	echo ${y[5]} ${y[6]} ${y[7]}
fi





