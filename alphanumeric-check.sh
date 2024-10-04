#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 data/*****.txt"
  exit 1
fi

filename=$1

if [ ! -f "$filename" ]; then
  echo "File not found!"
  exit 1
fi

line_number=0
issues_found=0

while IFS= read -r line || [ -n "$line" ]; do
  line_number=$((line_number + 1))
  # Remove carriage return characters if present
  line=$(echo "$line" | tr -d '\r')
  if [[ ! "$line" =~ ^[a-zA-Z0-9]*$ ]]; then
    echo "Line $line_number: $line"
    issues_found=$((issues_found + 1))
  fi
done < "$filename"

if [ $issues_found -eq 0 ]; then
  echo "No issues found. All lines contain only alphanumeric characters."
else
  echo "Warning: $issues_found line(s) contain non-alphanumeric characters."
fi
