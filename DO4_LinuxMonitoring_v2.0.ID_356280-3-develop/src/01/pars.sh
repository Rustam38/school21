#!/bin/bash

if [[ !(-d $path) ]];
then
    echo "Next time, enter the existing path in first option, goodbye"
    exit 1
fi

if [[ $count_folders =~ [^0-9] ]];
then
    echo "Next time enter a number in second option, goodbye"
    exit 1
else
    if [[ $count_folders -gt 100 || $count_folders -le 1 ]];
    then
        echo "Next time enter correct number in second option, goodbye"
        exit 1
    fi
fi

export count_sym_fol=${#name_folder_sym}
if [[ $count_sym_fol -gt 7 ]];
then
    echo "Next time enter number of letters less than seven in third option, goodbye"
    exit 1
else
    if [[ $name_folder_sym =~ [^A-Za-z] ]];
    then
        echo "Next time enter only letters in third option, goodbye"
        exit 1
    fi
fi

if [[ $count_files =~ [^0-9] ]];
then
    echo "Next time enter numbers in fourth option, goodbye"
    exit 1
else
    if [[ $count_files -gt 100 ]];
    then
        echo "Next time enter number less than 101 in fourth option, goodbye"
        exit 1
    fi
fi

export file_name=$(echo $name_file_sym | awk -F. '{print $1}')
export file_ext=$(echo $name_file_sym | awk -F. '{print $2}')

if [[ ${#file_name} -gt 7 || ${#file_ext} -gt 3 || ${#file_name} -le 1 || ${#file_ext} -le 1 ]];
then
    echo "Next time enter the correct number of letters in fifth option, goodbye"
    exit 1
else
    if [[ $file_name =~ [^a-zA-z] || $file_ext =~ [^a-zA-Z] ]];
    then
        echo "Next time enter only letters in fifth option, goodbye"
        exit 1;
    fi
fi

export size=$(echo $size_file | awk -F"[kK][bB]" '{print $1}')

if [[ ! (($size_file =~ Kb$ || $size_file =~ kb$)) || ($size =~ [^0-9]) ]];
then
    echo "Next time enter the size in kilobytes in sixth option, goodbye"
    exit 1
else
    if [[ $size -gt 100 || $size -le 1 ]];
    then
        echo "Next time enter the correct size: more 0, and less 101 in sixth option. Goodbye =D"
        exit 1;
    fi
fi

./flood.sh
