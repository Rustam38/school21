#!/bin/bash

# Директория для хранения метрик
METRICS_DIR="/var/www/html/metrics"
METRICS_FILE="$METRICS_DIR/index.html"

# Создаем директорию, если её нет
mkdir -p "$METRICS_DIR"

while true; do
    # Получаем метрики
    CPU_LOAD=$(cat /proc/loadavg | awk '{print $1}')
    RAM_TOTAL=$(free -k | awk '/Mem:/ {print $2}')
    RAM_USED=$(free -k | awk '/Mem:/ {print $3}')
    DISK_TOTAL=$(df -k / | awk 'NR==2 {print $2}')
    DISK_USED=$(df -k / | awk 'NR==2 {print $3}')

    # Формируем файл в формате Prometheus (без HTML-тегов!)
    cat <<EOF > "$METRICS_FILE"
# HELP cpu_load Current CPU load (1min average)
# TYPE cpu_load gauge
cpu_load $CPU_LOAD
# HELP ram_total_kb Total RAM in kilobytes
# TYPE ram_total_kb gauge
ram_total_kb $RAM_TOTAL
# HELP ram_used_kb Used RAM in kilobytes
# TYPE ram_used_kb gauge
ram_used_kb $RAM_USED
# HELP disk_total_kb Total disk space in kilobytes
# TYPE disk_total_kb gauge
disk_total_kb $DISK_TOTAL
# HELP disk_used_kb Used disk space in kilobytes
# TYPE disk_used_kb gauge
disk_used_kb $DISK_USED
EOF

    sleep 3
done
