#!/bin/bash

function usage { 
echo "help :"
echo "	-p - output path for mp3 files
	-l - use path to mount point of the last mounted disk
	-v - show current version
	-s - unmount disk and run low-level sorting of FAT partition
	-h - show help"; exit 1; }
function sharg { echo "s = ${s}"; echo "p = ${p}"; exit 0; }

function convert
{ 
	echo ' ffmpeg '$path 'some options'
}

while getopts ":h:p:l:v:s:" o; do
    case "${o}" in
        h)
		usage
            ;;
        p)
            path=${OPTARG}
		echo ${o}
	    convert
            ;;
	l) 
	    echo $heedhelp
	    echo ${OPTARG}
	    ;;
	v)

	    ;;
	s)

	    ;;
        *)
	    echo 'use fionna -f for help'
	    exit 1
            ;;
    esac
done
    
if [ $# == 0 ]; then usage; fi

shift $((OPTIND-1))
