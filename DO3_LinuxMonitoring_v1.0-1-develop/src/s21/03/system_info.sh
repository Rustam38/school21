#!/bin/bash

get_hostname() {
    hostname
}

get_timezone() {
    local timezone=$(timedatectl | grep "Time zone" | awk '{print $3}')
    local offset=$(date +"%z" | sed 's/\(..\)\(..\)/\1:\2/')
    echo "$timezone UTC $offset"
}

get_user() {
    whoami
}

get_os() {
    echo "$(lsb_release -ds) $(uname -m)"
}

get_date() {
    date +"%d %b %Y %H:%M:%S"
}

get_uptime() {
    uptime -p | sed 's/^up //'
}

get_uptime_seconds() {
    cat /proc/uptime | awk '{print int($1)}'
}

get_ip() {
    hostname -I | awk '{print $1}'
}

get_mask() {
    # Определяем сетевой интерфейс с маршрутом по умолчанию
    local interface=$(ip route | grep default | awk '{print $5}')
    
    # Проверка, нашли ли интерфейс
    if [[ -z "$interface" ]]; then
        echo "Ошибка: не удалось определить сетевой интерфейс."
        return 1
    fi

    # Получаем маску подсети в виде префикса (например, 24)
    local prefix=$(ip -o -4 addr show "$interface" | awk '{print $4}' | cut -d/ -f2)

    # Проверка, нашли ли маску
    if [[ -z "$prefix" ]]; then
        echo "Ошибка: не удалось определить маску подсети."
        return 1
    fi

    # Преобразуем префикс в формат xxx.xxx.xxx.xxx
    local mask=$((0xFFFFFFFF << (32 - prefix) & 0xFFFFFFFF))
    printf "%d.%d.%d.%d\n" \
        $(( (mask >> 24) & 0xFF )) \
        $(( (mask >> 16) & 0xFF )) \
        $(( (mask >> 8) & 0xFF )) \
        $(( mask & 0xFF ))

}

get_gateway() {
    ip route | grep default | awk '{print $3}'
}

get_ram_total() {
    free -m | awk '/Mem:/ {printf "%.3f GB", $2/1024}'
}

get_ram_used() {
    free -m | awk '/Mem:/ {printf "%.3f GB", $3/1024}'
}

get_ram_free() {
    free -m | awk '/Mem:/ {printf "%.3f GB", $4/1024}'
}

get_space_root() {
    df / | awk 'NR==2 {printf "%.2f MB", $2/1024}'
}

get_space_root_used() {
    df / | awk 'NR==2 {printf "%.2f MB", $3/1024}'
}

get_space_root_free() {
    df / | awk 'NR==2 {printf "%.2f MB", $4/1024}'
}
