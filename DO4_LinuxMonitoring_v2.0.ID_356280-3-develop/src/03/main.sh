#!/bin/bash

if [[ $# != 1 ]];
then
    echo "Next time enter one option"
    exit 1
else
    if [[ $1 =~ [^0-9] ]];
    then
        echo "Next time enter the number"
        exit 1
    else
        export mode=$1
        ./mode.sh
    fi
fi
