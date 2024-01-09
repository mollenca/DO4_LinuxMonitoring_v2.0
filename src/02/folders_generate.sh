#!/bin/bash

max_folders=100
all_folders=$(find / -type d 2> /dev/null -not -path "*/bin/*" -not -path "*/sbin/*" -not -path "*/sys/*") 
random_folders=$(echo "$all_folders" | shuf -n "$max_folders")
letters=$1
length=${#letters}
folders=0
iteration=1


function less_than_five {
    if [[ $length -eq 1 ]]; then
        base="$letters$letters$letters$letters$letters"
    else
        for (( j = 0; j < length; j++ )); do
                sign="${letters:j:1}"
                base="$base$sign$sign$sign"
        done
    fi
}

if [[ $length -lt 5 ]]; then
    less_than_five
else
    base=$letters
fi

name="${base}"

initial_path=$(pwd)

available_space=$(df -h -m / | awk '{print $4}' | awk 'NR==2' | sed 's/G//')

while (( $available_space > 1024 )); do
    for folder in $random_folders; do
        if [ -w "$folder" ]; then
            cd $folder

            available_space=0
            folder_name=""
    
            if (( iteration % 2 == 0 )); then
                char="${name:0:1}"
                name="${char}${name}"
            else
                name=$(echo "$name" | awk 'BEGIN{FS=""; OFS=""} {$(NF+1)=$NF} 1')
            fi

            folder_name+="$(echo $name)"
            folder_name+="_"
            folder_name+=$(date +"%d%m%y")

            available_space=$(df -h -m / | awk '{print $4}' | awk 'NR==2' | sed 's/G//')

            if (( $available_space < 1024)); then
                break
            fi 

            mkdir $folder_name 2>/dev/null
            folder_path=$(pwd)
            echo -e "$(date +"%Y-%m-%d %R") - $folder_path/$folder_name" >> $log_path/log.txt

            cd $folder_name 2>/dev/null
            files_generation
            cd - > /dev/null

            cd "$initial_path"

            ((iteration++))
        fi
    done <<< "$random_folders"   
    available_space=$(df -h -m / | awk '{print $4}' | awk 'NR==2' | sed 's/G//')
done
echo "В файловой системе осталось около 1 ГБ свободного места. Процесс остановлен."
