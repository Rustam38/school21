#!/bin/bash

if [[ $# == 6 ]]; then
    export path=$1
    export count_folders=$2
    export name_folder_sym=$3
    export count_files=$4
    export name_file_sym=$5
    export size_file=$6

    ./pars.sh
else
    echo "Input 6 params"
fi
