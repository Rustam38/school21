#!/bin/bash

# Подключаем функции из system_info.sh
source ./system_info.sh

# Цвета для фона и текста
declare -A COLORS=(
    [1]="\033[47m" # white
    [2]="\033[41m" # red
    [3]="\033[42m" # green
    [4]="\033[44m" # blue
    [5]="\033[45m" # purple
    [6]="\033[40m" # black
)
declare -A FONT_COLORS=(
    [1]="\033[37m" # white
    [2]="\033[31m" # red
    [3]="\033[32m" # green
    [4]="\033[34m" # blue
    [5]="\033[35m" # purple
    [6]="\033[30m" # black
)
RESET="\033[0m"

# Проверка входных параметров
if [[ $# -ne 4 ]]; then
    echo "Ошибка: скрипт должен быть запущен с четырьмя числовыми параметрами от 1 до 6."
    echo "Пример: $0 1 3 4 5"
    exit 1
fi

# Проверка допустимости значений
for param in "$@"; do
    if ! [[ "$param" =~ ^[1-6]$ ]]; then
        echo "Ошибка: все параметры должны быть числами от 1 до 6."
        echo "Пример: $0 1 3 4 5"
        exit 1
    fi
done

# Проверка на совпадение цветов
if [[ "$1" -eq "$2" ]]; then
    echo "Ошибка: фон и цвет шрифта названий значений совпадают."
    exit 1
fi

if [[ "$3" -eq "$4" ]]; then
    echo "Ошибка: фон и цвет шрифта значений совпадают."
    exit 1
fi

# Установка цветов
BG_TITLE=${COLORS[$1]}
FG_TITLE=${FONT_COLORS[$2]}
BG_VALUE=${COLORS[$3]}
FG_VALUE=${FONT_COLORS[$4]}

# Получение данных
HOSTNAME=$(get_hostname)
TIMEZONE=$(get_timezone)
USER=$(get_user)
OS=$(get_os)
DATE=$(get_date)
UPTIME=$(get_uptime)
UPTIME_SEC=$(get_uptime_seconds)
IP=$(get_ip)
MASK=$(get_mask)
GATEWAY=$(get_gateway)
RAM_TOTAL=$(get_ram_total)
RAM_USED=$(get_ram_used)
RAM_FREE=$(get_ram_free)
SPACE_ROOT=$(get_space_root)
SPACE_ROOT_USED=$(get_space_root_used)
SPACE_ROOT_FREE=$(get_space_root_free)

# Функция для форматированного вывода
print_row() {
    local title=$1
    local value=$2
    echo -e "${BG_TITLE}${FG_TITLE} ${title} ${RESET} = ${BG_VALUE}${FG_VALUE} ${value} ${RESET}"
}

# Вывод данных
print_row "HOSTNAME" "$HOSTNAME"
print_row "TIMEZONE" "$TIMEZONE"
print_row "USER" "$USER"
print_row "OS" "$OS"
print_row "DATE" "$DATE"
print_row "UPTIME" "$UPTIME"
print_row "UPTIME_SEC" "$UPTIME_SEC"
print_row "IP" "$IP"
print_row "MASK" "$MASK"
print_row "GATEWAY" "$GATEWAY"
print_row "RAM_TOTAL" "$RAM_TOTAL"
print_row "RAM_USED" "$RAM_USED"
print_row "RAM_FREE" "$RAM_FREE"
print_row "SPACE_ROOT" "$SPACE_ROOT"
print_row "SPACE_ROOT_USED" "$SPACE_ROOT_USED"
print_row "SPACE_ROOT_FREE" "$SPACE_ROOT_FREE"
