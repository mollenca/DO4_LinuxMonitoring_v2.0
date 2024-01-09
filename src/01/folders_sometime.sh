#!/bin/bash

letters=$3
length=${#letters}
max_folders=$2
folders=0
count=1

cd $1

function less_than_four {
    if [[ length -eq 1 ]]; then
        base="$letters$letters$letters$letters"
    else
        for (( j = 0; j < length; j++ )); do
                sign="${letters:j:1}"
                base="$base$sign$sign"
        done
    fi
}

    
if [[ $length -lt 4 ]]; then
    less_than_four
else
    base=$3
fi


base_length=${#base}

while (( folders < max_folders )); do
    for (( j = 0; j <= base_length; j++ )); do
        folder_name=""
        name=""
        for (( e = 0; e < base_length; e++ )); do
            char="${base:e:1}"
            if [[ $e -lt j ]]; then 
                name+="${char}${char}"
            else
                name+="${char}"
            fi
        done
        folder_name+="$(echo $name)"
        folder_name+="_"
        folder_name+=$(date +"%d%m%y")    
        mkdir $folder_name

        ((folders++))
        if (( folders >= max_folders)); then
            break
        fi
    done
    ((count++))
    if (( count > base_length )); then
        count=1
        base="${name}"
        if (( folders >= max_folders )); then
            break
        fi
    fi
done
