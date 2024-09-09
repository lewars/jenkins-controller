#!/bin/bash

# Check if a virtual environment path is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <path_to_venv>"
    exit 1
fi

VENV_PATH="$1"
BIN_DIR="$VENV_PATH/bin"
NEW_SHEBANG="#!/usr/bin/env python3"

# Check if the bin directory exists
if [ ! -d "$BIN_DIR" ]; then
    echo "Error: $BIN_DIR does not exist."
    exit 1
fi

# Update shebang for each file in the bin directory
for file in "$BIN_DIR"/*; do
    if [ -f "$file" ] && [ "${file##*.}" != "py" ]; then
        first_line=$(head -n 1 "$file")
        if [[ $first_line == \#!* ]]; then
            sed -i "1s|.*|$NEW_SHEBANG|" "$file"
            echo "Updated shebang for $(basename "$file")"
        fi
    fi
done

echo "Shebang update complete."
