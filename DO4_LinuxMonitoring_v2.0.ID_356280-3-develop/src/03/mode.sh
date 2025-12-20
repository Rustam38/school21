#!/bin/bash

case $mode in

    1)
        number_folders=$(cat ../02/logfiles | awk -F"|" '{print $2}' | awk -F"/" '{printf "/%s/%s\n", $2, $3}' | sort | uniq | wc | awk '{print $1}')
        for (( i=1; i<=$number_folders; i++));
        do
            sudo rm -rf $(cat ../02/logfiles | awk -F"|" '{print $2}'| awk -F"/" '{printf "/%s/%s\n", $2, $3}' | sort | uniq | head -n$i | tail -n1)
        done;;

    2)
        echo "Insert Start time HH:MM"
        read start_time
        echo "Insert end time HH:MM"
        read end_time
        sudo find / -type f -newermt "$start_time" -not -newermt "$end_time" -delete 2>/dev/null;;

    3)
        echo "Insert mask of name"
        read mask
        sudo find / -type f -name "*$mask*.*" -delete 2>/dev/null;;

esac
