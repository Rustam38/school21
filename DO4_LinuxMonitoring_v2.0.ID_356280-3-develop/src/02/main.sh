#!/bin/bash
START=$(date +%s%N)
export TIME=$(date +%H:%M)

if [[ $# == 3 ]];
then
    export name_fold_sym=$1
    export name_file_ext_sym=$2
    export size=$3

    ./proof.sh
    END=$(date +%s%N)
    TIMEUP=$((($END - $START)/1000000))
    ENDTIME=$(date +%H:%M)
    echo "Start time: $TIME"
    echo "End time: $ENDTIME"
    echo "Worktime: $TIMEUP ms"
else
    echo "Next time enter the three params"
fi
