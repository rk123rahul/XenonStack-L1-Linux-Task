#! /bin/bash	

help() {
echo "vvbs"
}

version() {
echo "v0.1.0"
}



#memory information
getMemoryInfo(){
free
}


#cpu information

getCpuInfo(){
lscpu
}

if [[ "$@" == "cpu getinfo" ]]
then
	getCpuInfo

elif [[ "$@" == "memory getinfo" ]]
then
	getMemoryInfo
fi

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
