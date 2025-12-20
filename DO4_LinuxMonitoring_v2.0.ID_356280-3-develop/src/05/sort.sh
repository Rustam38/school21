#!/bin/bash

case $mode in

    1)
        sort -k 8 ../04/*.log
        ;;

    2)
        awk '{print $1}' ../04/*.log | sort | uniq
        ;;

    3)
        awk '$9 ~/[45]/' ../04/*.log
        ;;

    4)
        awk '$9 ~/[45]/' ../04/*.log | awk '{print $1}' | sort | uniq
        ;;

esac
