#!/bin/bash

echo -e "Запишите дату файлов, которые вы хотите начать удалять, в формате \033[31mYYYY-MM-DD HH:MM\033[0m"
read birth_time

echo -e "Запишите дату завершения удаления файлов в формате \033[31mYYYY-MM-DD HH:MM\033[0m"
read end_time

start=$(date -d "$birth_time" +%s)
end=$(date -d "$end_time" +%s)

while read -r line; do
    time=$(echo "$line" | awk -F ' - ' '{print $1}')
    dir=$(echo "$line" | awk -F ' - ' '{print $2}')

    dir_time=$(date -d "$time" +%s)

    if [[ $dir_time -ge $start && $dir_time -le $end ]]; then
        if [[ -d $dir ]]; then
            rm -r "$dir"
            echo "${dir} удаленный"
        fi
    fi

done < "$logfile"

