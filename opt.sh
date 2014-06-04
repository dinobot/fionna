#!/bin/bash

. version

function usage 
{ 
echo "help :"
echo "	-p - output path for mp3 files
	-l - use path to mount point of the last mounted disk
	-v - show current version
	-s - unmount disk and run low-level sorting of FAT partition
	-h - show help"; exit 1 
}

function convert
{ 
	echo ' ffmpeg '$path 'some options'
}

function get_last_path
{
	if [ "$(uname -s)" == "Darwin" ];then
		last_mount=$(diskutil list | tail -n1 | awk '{print $NF}' | xargs diskutil info | grep 'Mount Point' | awk '{print $3}') 
	elif [ "$(uname -s)" == "Linux" ];then
		last_mount=$(mount | tail -n1 | cut -f3 -d' ')
		echo $last_mount
	else 
		echo 'looks like your system is not supported yet'
	fi
}

while getopts "hp:l:vs" o; do
    case "${o}" in
        h)
		usage
            ;;
        p)
            path=${OPTARG}
	    convert
            ;;
	l)
	   get_last_path

  	   if [ "${OPTARG}" == "y" ] || [ "${OPTARG}" == "yes" ]; then
		path=$last_mount; convert
	   elif [ "${OPTARG}" == "l" ] || [ "${OPTARG}" == "list" ]; then 
		echo $last_mount		
	   else 
		echo '-l list 
			to show last path
		      -l y || yes
			to go'
	   fi
	    ;;
	v)
	    echo 'version is :' $version
	    ;;
	s)

	    ;;
        *)
	    echo 'use fionna -h for help'
	    exit 1
            ;;
    esac
done
    
if [ $# == 0 ]; then usage; fi

shift $((OPTIND-1))
