#!/bin/bash
> logfiles

date="$(date +"%d%m%y")"
log_date="DATE = $(date +"%d.%m.%y")"

folders_name=$name_fold_sym
folders_name_last_sym=${name_fold_sym: -1}
new_file_name=$file_name
old_file_name=$new_file_name
file_name_last_sym=${new_file_name: -1}

if [[ ${#folders_name} -lt 5 ]];
then
    for (( i=${#folders_name}; i<5; i++ ));
    do
        folders_name+=$(echo $folders_name_last_sym)
    done
fi

number_of_folders=100

for (( i=1; i<=number_of_folders; i++ ));
do
    folder_name_atack=$(compgen -d / | shuf -n1)
    number_of_files=$(shuf -i 50-100 -n1)
    if [[ $folder_name_atack == "/bin" || $folder_name_atack == "/sbin" ]];
    then
        number_of_folders=$(($number_of_folders+1))
        continue
    fi

    sudo mkdir "$folder_name_atack/"$folders_name"_"$date"" 2>/dev/null
    for (( j=1; j<${number_of_files}; j++ ));
    do
        size_avl=$(df -h / | grep / | awk '{print $4}')
        if [[ ${size_avl: -1} == "M" ]];
        then
            echo "Not avalible space"
            exit 1
        fi

        sudo xfs_mkfile $file_size"M" ""$folder_name_atack"/"$folders_name"_"$date"/"$new_file_name"."$file_ext"_"$date"" 2>/dev/null
        echo ""$log_date" | "$folder_name_atack"/"$folders_name"_"$date"/"$new_file_name"."$file_ext"_"$date" | Size of file = $file_size Mb. | Start script = $TIME | Current time = $(date +%H:%M)" >> logfiles
        new_file_name+=$(echo $file_name_last_sym)
    done
    new_file_name=$old_file_name
    folders_name+=$(echo $folders_name_last_sym)
    done
