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

total_entries=0
unique_files=0
changed_files=0

array_filename=()
count=0
hash_old=0
hash_new=0
while IFS= read -r line; do
  IFS=" " read -r file_path t1 file_size t2 datetime1 datetime2 t3 hash t4 algorithm <<< "$line" 
   if [ $total_entries -eq 0 ]; then
    hash_old=$hash
    hash_new=$hash
  else
    hash_old=$hash_new
    hash_new=$hash
     if [[ hash_new != hash_old ]]; then
     ((changed_files++))
     fi
  fi
  ((total_entries++))
  filename=$(basename $file_path)
  array_filename+=($filename)
done < "$log_file_path"

unique_array=()

# Проходим по исходному массиву
for element in "${array_filename[@]}"; do
    if [[ ! " ${unique_array[@]} " =~ " $element " ]]; then
        unique_array+=("$element")
    fi
done


echo "Общее количество записей: $total_entries"
echo "Количество уникальных файлов: ${#unique_array[@]}"
echo "Количество изменений хэш-суммы: $changed_files"

