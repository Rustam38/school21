#!/bin/bash

if [[ $# != 0 ]];
then
    echo "No params!"
else
    goaccess ../04/*.log --log-format=COMBINED --invalid-requests=invalid.log -a -o index.html
fi
