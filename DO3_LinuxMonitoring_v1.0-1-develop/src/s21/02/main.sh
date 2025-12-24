#!/bin/bash

# Подключаем модули
source ./system_info.sh
source ./utils.sh

# Получаем данные о системе
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

# Вывод данных на экран
echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE = $DATE"
echo "UPTIME = $UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL"
echo "RAM_USED = $RAM_USED"
echo "RAM_FREE = $RAM_FREE"
echo "SPACE_ROOT = $SPACE_ROOT"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"

# Предложение записать данные в файл
read -p "Сохранить данные в файл? (Y/N): " choice
if is_yes "$choice"; then
    FILENAME=$(date +"%d_%m_%y_%H_%M_%S").status
    {
        echo "HOSTNAME = $HOSTNAME"
        echo "TIMEZONE = $TIMEZONE"
        echo "USER = $USER"
        echo "OS = $OS"
        echo "DATE = $DATE"
        echo "UPTIME = $UPTIME"
        echo "UPTIME_SEC = $UPTIME_SEC"
        echo "IP = $IP"
        echo "MASK = $MASK"
        echo "GATEWAY = $GATEWAY"
        echo "RAM_TOTAL = $RAM_TOTAL"
        echo "RAM_USED = $RAM_USED"
        echo "RAM_FREE = $RAM_FREE"
        echo "SPACE_ROOT = $SPACE_ROOT"
        echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
        echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
    } > "$FILENAME"
    echo "Данные сохранены в файл $FILENAME."
else
    echo "Данные не сохранены."
fi
