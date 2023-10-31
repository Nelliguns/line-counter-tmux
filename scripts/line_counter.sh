#!/bin/bash

# Check for correct number of arguments
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <directory> <venv_name> <file_extensions...>"
    exit 1
fi

# Set the directory to search in
directory="$1"

# Set the virtual environment name
venv_name="$2"

# Remove the first two arguments (directory and venv_name) to get the file extensions
shift 2

# Initialize a variable to store the total lines of code
total_lines=0

# Loop through the provided file extensions
for extension in "$@"; do
    # Use 'find' to locate files with the specified extension and count their lines
    while IFS= read -r -d '' file; do
        # Check if the file is outside the virtual environment directory
        if [[ "$file" != "$directory/$venv_name"* ]]; then
            # Count non-empty lines (ignoring lines that contain only whitespace)
            lines=$(grep -v '^[[:space:]]*$' "$file" | wc -l)
            total_lines=$((total_lines + lines))
        fi
    done < <(find "$directory" -type f -name "*.$extension" -print0)
done

# Print the total lines of code
echo "Total lines of code $total_lines"

