#!/bin/bash

log_file_path="$1"

if [ -z "$log_file_path" ]; then
  echo "Использование: $0 <путь_к_файлу_лога>"
  exit 1
fi

if [ ! -f "$log_file_path" ]; then
  echo "Файл лога не существует: $log_file_path"
  exit 1
fi

# Инициализируем счетчики
total_entries=0
unique_files=0
changed_files=0


# Читаем каждую строку из файла лога
while IFS= read -r line; do
  # Разбиваем строку на поля, разделенные тире
  IFS="-" read -r file_path file_size datetime hash algorithm <<< "$line"
  ((total_entries++))
done < "$log_file_path"

# Выводим результаты
echo "Общее количество записей: $total_entries"
echo "Количество уникальных файлов: $unique_files"
echo "Количество изменений хэш-суммы: $changed_files"

