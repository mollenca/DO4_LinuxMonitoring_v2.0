#!/bin/bash

logfile="../02/log.txt"

. ./check.sh

case $1 in
    1) . ./rm_log.sh ;;
    2) . ./rm_date.sh ;;
    3) . ./rm_mask.sh ;;
esac


