#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <README.md>"
    exit 1
fi

FILE="$1"

# Check if the file exists
if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found!"
    exit 1
fi

echo "Table of Contents"
echo ""

# Extract headings and building the table of content
grep '^#' "$FILE" | while read -r line; do
    LEVEL=$(echo "$line" | grep -o '^#\+' | wc -c)
    LEVEL=$((LEVEL - 1))
    TITLE=$(echo "$line" | sed -E 's/^#+\s+//')
    INDENT=$(printf '  %.0s' $(seq 1 $LEVEL))
    echo "${INDENT}- $TITLE"
done


 

	

