#!/bin/bash

if [[ (${#name_fold_sym} -gt 7)  || ($name_fold_sym =~ [^A-Za-z])]];
then
    echo "Next time enter less than 8 and more than 0 letters"
    exit 1
fi

export file_name=$(echo $name_file_ext_sym | awk -F. '{print $1}')
export file_ext=$(echo $name_file_ext_sym | awk -F. '{print $2}')

if [[ ${#file_name} -gt 7 || ${#file_name} -le 0  || ${#file_ext} -gt 3 || ${#file_ext} -le 0\
    || $file_name =~ [^A-Za-z] || $file_ext =~ [^A-Za-z] ]];
then
    echo "Next time enter less than 8 and more than 0 letters of file name \
        and less than 4 and more than 0 of file ext"
    exit 1
fi

export file_size=$(echo $size | awk -F"Mb" '{print $1}')
if [[ !($size =~ Mb$) ||  ($file_size =~ [^0-9]) || ($file_size -gt 100 ) || ($file_size -le 0) ]];
then
    echo "Next time enter the right size in Mb"
    exit 1
fi

./flood.sh
