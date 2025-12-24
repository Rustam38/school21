#!/bin/bash

# Файл конфигурации
CONFIG_FILE="config.cfg"

# Значения по умолчанию
DEFAULT_COLUMN1_BACKGROUND=6  # black
DEFAULT_COLUMN1_FONT_COLOR=1  # white
DEFAULT_COLUMN2_BACKGROUND=2  # red
DEFAULT_COLUMN2_FONT_COLOR=4  # blue

# Названия цветов
COLORS=("default" "white" "red" "green" "blue" "purple" "black")

# Функция чтения конфигурационного файла
load_config() {
    if [[ -f $CONFIG_FILE ]]; then
        source $CONFIG_FILE
    fi

    # Устанавливаем значения, если они не заданы в конфигурации
    column1_background=${column1_background:-$DEFAULT_COLUMN1_BACKGROUND}
    column1_font_color=${column1_font_color:-$DEFAULT_COLUMN1_FONT_COLOR}
    column2_background=${column2_background:-$DEFAULT_COLUMN2_BACKGROUND}
    column2_font_color=${column2_font_color:-$DEFAULT_COLUMN2_FONT_COLOR}
}

# Проверка на совпадение цветов фона и текста
validate_colors() {
    if [[ $column1_background -eq $column1_font_color ]]; then
        echo "Ошибка: Цвет фона и текста для первой колонки совпадают."
        exit 1
    fi

    if [[ $column2_background -eq $column2_font_color ]]; then
        echo "Ошибка: Цвет фона и текста для второй колонки совпадают."
        exit 1
    fi
}

# Функция вывода информации о системе
print_system_info() {
    source system_info.sh

    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mHOSTNAME\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_hostname)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mTIMEZONE\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_timezone)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mUSER\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_user)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mOS\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_os)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mDATE\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_date)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mUPTIME\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_uptime)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mUPTIME_SEC\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_uptime_seconds)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mIP\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_ip)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mMASK\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_mask)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mGATEWAY\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_gateway)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mRAM_TOTAL\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_ram_total)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mRAM_USED\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_ram_used)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mRAM_FREE\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_ram_free)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mSPACE_ROOT\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_space_root)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mSPACE_ROOT_USED\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_space_root_used)\e[0m"
    echo -e "\e[4${column1_background}m\e[3${column1_font_color}mSPACE_ROOT_FREE\e[0m = \e[4${column2_background}m\e[3${column2_font_color}m$(get_space_root_free)\e[0m"
}

# Функция вывода цветовой схемы
print_color_scheme() {
    echo ""
    echo "Column 1 background = ${COLORS[column1_background]} (${column1_background})"
    echo "Column 1 font color = ${COLORS[column1_font_color]} (${column1_font_color})"
    echo "Column 2 background = ${COLORS[column2_background]} (${column2_background})"
    echo "Column 2 font color = ${COLORS[column2_font_color]} (${column2_font_color})"
}

# Основной сценарий
load_config
validate_colors
print_system_info
print_color_scheme
