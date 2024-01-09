#!/bin/bash

while IFS= read -r line; do
    path=$(echo "$line" | awk -F " - " '{print $2}')
    if [[ -d $path ]]; then
        rm -r "$path"
        echo "${path} удаленный"
    fi

done < "$logfile"