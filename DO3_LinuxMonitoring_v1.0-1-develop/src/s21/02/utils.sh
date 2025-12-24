#!/bin/bash

is_yes() {
    local input=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    if [[ "$input" == "y" ]]; then
        return 0
    else
        return 1
    fi
}
