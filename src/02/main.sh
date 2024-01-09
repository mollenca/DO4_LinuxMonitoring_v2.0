#!/bin/bash


. ./check.sh

touch log.txt
chmod +x log.txt
log_path=$(pwd)

start=$(date +%T)
start_for_execution=$(date +%s) 
echo -e "\n$start - Start time of the script\n" >> $log_path/log.txt

chmod +x files_generate.sh

. ./files_generate.sh
. ./folders_generate.sh

end=$(date +%T)
end_for_execution=$(date +%s)
echo -e "\n$end - End time of the script" >> $log_path/log.txt

execution=$(($end_for_execution - $start_for_execution))
execution_hours=$(($execution / 3600))
execution_minutes=$(($execution % 3600 / 60))
execution_seconds=$execution

echo -e "\n$execution_hours:$execution_minutes:$execution - Running time of the script" >> $log_path/log.txt
echo -e "\n$start - Start time of the script\n\n$end - End time of the script\n\n$execution_hours:$execution_minutes:$execution - Running time of the script"