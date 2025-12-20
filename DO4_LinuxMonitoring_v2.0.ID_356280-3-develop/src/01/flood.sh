#!/bin/bash

> logfile

name_of_folders=$name_folder_sym
name_of_files=$file_name
hold_fille_name=$name_of_files
sym_of_fold=${name_folder_sym: -1}
sym_of_file=${name_of_files: -1}
old_date=$(date +"%d%m%y")
new_date="DATE = $(date +"%d"."%m"."%y")"

if [[ ${#name_of_folders} -lt 4 ]];
then
    for (( i =${#name_of_folders}; i < 4; i++ ));
    do
        name_of_folders+=$(echo $sym_of_fold)
    done
fi

for (( i=1; i<=$count_folders; i++ ));
do
    sudo mkdir "$path/"$name_of_folders"_"$old_date""
    stoper=$(df -h / | grep / | awk -F"G" '{print $3}' | awk -F. '{print $1}')
    if [[ $stoper -eq 1 || $stoper -le 1 ]];
    then
        echo "Avalible size less than 1Gb, goodbye!"
        exit 1
    fi
    for (( j=1; j<=$count_files; j++ ));
    do
        sudo xfs_mkfile $size"k" ""$path"/"$name_of_folders"_"$old_date"/"$name_of_files"."$file_ext"_"$old_date""
        echo "$new_date | "$path"/"$name_of_folders"_"$old_date"/"$name_of_files"."$file_ext"_"$old_date" | Size of file = $size Kb." >> logfile
        name_of_files+=$(echo $sym_of_file)
    done
    name_of_files=$hold_fille_name
    name_of_folders+=$(echo $sym_of_fold)
done
