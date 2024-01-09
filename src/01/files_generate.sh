#!/bin/bash

potential_name=$(echo "$5" | cut -d '.' -f 1)
extension=$(echo "$5" | cut -d '.' -f 2)
filesize=$(echo "$nsize" | sed 's/kb/K/')
length_pname=${#potential_name}
max_files=$4
iterations=1

function fless_than_four {
    start=""
    if [[ $length_pname -eq 1 ]]; then
        start="$potential_name$potential_name$potential_name$potential_name"
    else
        for (( j = 0; j < length_pname; j++ )); do
                fsign="${potential_name:j:1}"
                start="$start$fsign$fsign"
        done
    fi
}

function files_generation {
    files=0
    
    if [[ $length_pname -lt 4 ]]; then
        fless_than_four
    else
        start=$potential_name
    fi

    fname="${start}"

    while (( files < max_files )); do

        filename=""
    
        if (( iterations % 2 == 0 )); then
            fchar="${fname:0:1}"
            fname="${fchar}${fname}"
        else
            fname=$(echo "$fname" | awk 'BEGIN{FS=""; OFS=""} {$(NF+1)=$NF} 1')
        fi

        filename+="$(echo $fname)"
        filename+="_"
        filename+=$(date +"%d%m%y")
        filename+="." 
        filename+="$extension"

        fallocate -l "$filesize" "$filename" 2> /dev/null
        file_path=$(pwd)
        echo -e "$(date +"%Y-%m-%d") - $filesize - $file_path/$filename" >> $log_path/log.txt

        ((iterations++))
        ((files++))
    
    done
}
