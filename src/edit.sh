#!/bin/bash
file_path="$1"
search_string="$2"
replace_string="$3"

if [ ! -f "$1" ]; then
  echo "Файл не найден: $1"
  exit 1
fi

if [ -z "$2" ] || [ -z "$3" ]; then
  echo "Переменная пустая!"
  exit 1
fi


output=`sed "s/$2/$3/g" "$1"`
echo "$output" > $1

file_size=$(wc -c < "$1" | tr -s ' ')
file_timestamp=$(date +"%Y-%m-%d %H:%M")
sha_sum=$(shasum -a 256 "$1" | cut -d ' ' -f 1)

filename=$(basename "$1")

echo "$1 -$file_size – $file_timestamp – $sha_sum – sha256" >> ~/Desktop/projects/T02D02-1/src/files.log
