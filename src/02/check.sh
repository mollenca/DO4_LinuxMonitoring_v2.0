#!/bin/bash

if [[ $# -ne 3 ]]; then
	echo "Там должно быть три параметра."
	exit 1
fi


if ! [[ $1 =~ ^[a-zA-Z]{1,7}$ ]]; then 
	echo -e "Вы либо ввели что-то, что не является буквами\n\, либо ваши вводимые данные состоят более чем из 7 знаков для названия папок.\nПожалуйста, проверьте введенный вами 1-й параметр."
	exit 1
fi

if ! [[ $2 =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then 
	echo -e "Вы либо ввели что-то, что не является буквами\n\, потому что ваши входные данные состоят более чем из 7 знаков в имени файла.\Также вы либо ввели что-то, что не является буквами \n\, потому что ваши входные данные состоят более чем из 3 знаков в расширении файла.\nПожалуйста, проверьте ваши входные данные на наличие 2-го параметра."
	exit 1
fi

nsize=$3
if ! [[ $3 =~ ^[0-9]+Mb$ ]]; then
	if [[ $3 =~ ^[0-9]+$ ]]; then
		echo "Вы забыли написать "Mb", но не волнуйтесь. "я позабочусь о вас;)"
		nsize+="Mb"
	else
	echo "третьим параметром должен быть размер файлов.\nпожалуйста, введите цифры."
	exit 1
	fi
fi

digit="${nsize:0:-2}"
if ! (( digit <= 100 )); then
	echo -e "3-м параметром должен быть размер файлов не более 100.\nпожалуйста, проверьте ваши данные."
	exit 1
fi