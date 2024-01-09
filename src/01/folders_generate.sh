#!/bin/bash

path=$1
max_folders=$2
letters=$3
length=${#letters}
folders=0
iteration=1
required_space=$((1000*1000)) 

touch log.txt
echo ""
log_path=$(pwd)
cd "$path"

function less_than_four {
    if [[ $length -eq 1 ]]; then
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
    base=$letters
fi

name="${base}"

while (( folders <= max_folders )); do
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

   

    mkdir $folder_name
    folder_path=$(pwd)
    echo -e "$(date +"%Y-%m-%d") -     - $folder_path/$folder_name" >> $log_path/log.txt

    available_space=$(df -k / | awk '{print $4}' | awk 'NR==2')
    if [[ $available_space -lt $required_space ]]; then
        echo "В файловой системе осталось около 1 ГБ свободного места. Процесс остановлен."
        break
    fi 

    cd $folder_name
    files_generation
    cd - > /dev/null
    

    ((iteration++))
    ((folders++))
    
    if (( folders >= max_folders )); then
        break
    fi

    

    
done

