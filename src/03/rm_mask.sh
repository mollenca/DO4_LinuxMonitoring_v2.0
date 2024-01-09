#!/bin/bash

echo -e "Запишите маску файлов, которые вы хотите удалить, в формате \033[31m_DDMMYY\033[0m"
read mask
find / -type d -name "*$mask*" -print0 2>/dev/null|
while IFS= read -r -d '' dir; do
    rm -r "$dir"
    echo "${dir} deleted"
done 