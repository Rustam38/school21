#!/bin/bash

if [[ $# != 1 || $1 =~ [^1-4] ]];
then
    echo "Wrong option"
else
    export mode=$1
    ./sort.sh
fi
