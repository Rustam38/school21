#!/bin/bash

# Функция для подсчета общего числа папок
get_total_folders() {
    find "$1" -type d | wc -l
}

# Функция для подсчета топ-5 папок по размеру
get_top_folders() {
    du -h --max-depth=1 "$1" 2>/dev/null | sort -hr | head -n 5 | awk '{print NR " - " $2 ", " $1}'
}

# Функция для подсчета числа файлов
get_total_files() {
    find "$1" -type f | wc -l
}

# Функция для подсчета файлов по категориям
get_file_counts() {
    conf_files=$(find "$1" -type f -name "*.conf" | wc -l)
    text_files=$(find "$1" -type f -exec file --mime-type {} + | grep -c "text/")
    exec_files=$(find "$1" -type f -executable | wc -l)
    log_files=$(find "$1" -type f -name "*.log" | wc -l)
    archive_files=$(find "$1" -type f \( -name "*.tar" -o -name "*.gz" -o -name "*.zip" \) | wc -l)
    symlinks=$(find "$1" -type l | wc -l)

    echo "$conf_files $text_files $exec_files $log_files $archive_files $symlinks"
}

# Функция для получения топ-10 файлов по размеру
get_top_files() {
    find "$1" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{print NR " - " $2 ", " $1 ", " $3}'
}

# Функция для получения топ-10 исполняемых файлов с MD5
get_top_exec_files() {
    find "$1" -type f -executable -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | while read -r size path; do
        md5=$(md5sum "$path" 2>/dev/null | awk '{print $1}')
        echo "$size $path, $md5"
    done | awk '{print NR " - " $2 ", " $1 ", " $3}'
}

# Функция для подсчета времени выполнения
get_execution_time() {
    END_TIME=$(date +%s.%N)
    EXECUTION_TIME=$(echo "$END_TIME - $1" | bc)
    echo "$EXECUTION_TIME"
}

# Основная функция для печати всей информации о системе
print_system_info() {
    START_TIME=$(date +%s.%N)

    DIR="$1"

    total_folders=$(get_total_folders "$DIR")
    top_folders=$(get_top_folders "$DIR")
    total_files=$(get_total_files "$DIR")
    file_counts=$(get_file_counts "$DIR")
    top_files=$(get_top_files "$DIR")
    top_exec_files=$(get_top_exec_files "$DIR")
    execution_time=$(get_execution_time "$START_TIME")

    # Разделение переменной file_counts
    read conf_files text_files exec_files log_files archive_files symlinks <<< "$file_counts"

    # Вывод результатов
    echo "Total number of folders (including all nested ones) = $total_folders"
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    echo "$top_folders"
    echo "Total number of files = $total_files"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $conf_files"
    echo "Text files = $text_files"
    echo "Executable files = $exec_files"
    echo "Log files (with the extension .log) = $log_files"
    echo "Archive files = $archive_files"
    echo "Symbolic links = $symlinks"
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    echo "$top_files"
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    echo "$top_exec_files"
    echo "Script execution time (in seconds) = $execution_time"
}
