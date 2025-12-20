#!/bin/bash

#200 - OK
#201 - CREATED
#400 - BAD REQUEST
#401 - UNAUTHORIZED
#403 - FORBIDDEN
#404 - NOT FOUND
#500 - INTERNAL SERVER ERROR
#501 - NOT IMPLEMENTED
#502 - BAD GATEWAAY
#503 - SERVICE UNAVALIBLE

if [[ $# != 0 ]];
then
    echo "Bad value"
    exit 1
fi

files=5
day=15

rm -r *.log 2>/dev/null

for ((; files > 0; files--));
do
    H=0
    M=0
    S=0
    number_of_wrote=$(shuf -i 100-1000 -n1)
    for (( i=0; i < number_of_wrote; i++ ));
    do
        if [[ S -ge 55 ]];
        then
            M=$(($M + 1))
            S=0
        else
            S=$(($S + 4))
        fi
        if [[ M -ge 58 ]];
        then
            H=$(($H + 1))
            M=0
        else
            M=$(($M + $(shuf -i 1-2 -n1)))
        fi

        echo -n "$(shuf -i 0-255 -n1).$(shuf -i 0-255 -n1).$(shuf -i 0-255 -n1).$(shuf -i 0-255 -n1)" >> "day"$files.log
        echo -n " - - " >> "day"$files.log
        echo -n "[$day$(date +/%b/%Y):$H:$M:$S +0000]" >> "day"$files.log
        echo -n " \"$(shuf -n1 methods) " >> "day"$files.log
        echo -n "$(shuf -n1 url) " >> "day"$files.log
        echo -n "$(shuf -n1 protocols)\" " >> "day"$files.log
        echo -n "$(shuf -n1 codes) " >> "day"$files.log
        echo -n $RANDOM >> "day"$files.log
        echo -n " \"-\" " >> "day"$files.log
        echo -n "\"$(shuf -n1 agents)\"" >> "day"$files.log
        echo "" >> "day"$files.log
    done
    day=$(($day - 1))
done
