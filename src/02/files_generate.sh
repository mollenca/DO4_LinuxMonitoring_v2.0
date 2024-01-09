#!/bin/bash

potential_name=$(echo "$2" | cut -d '.' -f 1)
extension=$(echo "$2" | cut -d '.' -f 2)
filesize=$(echo "$nsize" | sed 's/Mb/M/')
length_pname=${#potential_name}
iterations=1

function fless_than_five {
    fbase=""
    if [[ $length_pname -eq 1 ]]; then
        fbase="$potential_name$potential_name$potential_name$potential_name$potential_name"
    else
        for (( j = 0; j < length_pname; j++ )); do
                fsign="${potential_name:j:1}"
                fbase="$fbase$fsign$fsign$fsign"
        done
    fi
}

function files_generation {
    files=$(shuf -i 1-10 -n 1)
    
    if [[ $length_pname -lt 5 ]]; then
        fless_than_five
    else
        fbase=$potential_name
    fi

    fname="${fbase}"

    for (( i = 1; i <= $files; i++ )); do
        filename=""
        available_space=0
    
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

        available_space=$(df -h -m / | awk '{print $4}' | awk 'NR==2' | sed 's/G//')

        if (( $available_space < 1024)); then
            break
        fi 
        
        fallocate -l "$filesize" "$filename" 2>/dev/null
        file_path=$(pwd)
        echo -e "$(date +"%Y-%m-%d %R") - $file_path/$filename - $filesize" >> $log_path/log.txt

        ((iterations++))
    
    done
}
