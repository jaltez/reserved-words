#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

data_dir="data"

# Check if the data directory exists
if [ ! -d "$data_dir" ]; then
  echo -e "${RED}Error: $data_dir directory not found!${NC}"
  exit 1
fi
  
# Scan each file in the data directory
for filename in "$data_dir"/*; do
  if [ -f "$filename" ]; then
    echo -e "${YELLOW}Processing file: $filename${NC}"
    
    line_number=0
    issues_found=0

    # Read each line in the file
    while IFS= read -r line || [ -n "$line" ]; do
      line_number=$((line_number + 1))
      # Remove carriage return characters if present
      line=$(echo "$line" | tr -d '\r')
      if [[ ! "$line" =~ ^[a-zA-Z0-9]*$ ]]; then
        echo -e "  ${RED}Line $line_number: $line${NC}"
        issues_found=$((issues_found + 1))
      fi
    done < "$filename"

    # Check if all lines contain only alphanumeric characters
    if [ $issues_found -eq 0 ]; then
      echo -e "  ${GREEN}Success: All lines contain only alphanumeric characters.${NC}"
    else
      echo -e "  ${RED}Warning: $issues_found line(s) contain non-alphanumeric characters.${NC}"
    fi
    echo ""
  fi
done

echo -e "${YELLOW}Scan completed.${NC}"
