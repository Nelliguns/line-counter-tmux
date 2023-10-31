#!/bin/bash

# Check for correct number of arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <directory> <file_extensions...>"
    exit 1
fi

# Set the directory to search in
directory="$1"

# Remove the first argument (directory) to get the file extensions
shift

# Initialize a variable to store the total lines of code
total_lines=0

# Loop through the provided file extensions
for extension in "$@"; do
    # Use 'find' to locate files with the specified extension and count their lines
    while IFS= read -r -d '' file; do
        # Count non-empty and non-comment lines
        lines=$(grep -c -vE '^\s*($|#|//)' "$file")
        total_lines=$((total_lines + lines))
    done < <(find "$directory" -type f -name "*.$extension" -print0)
done

# Print the total lines of code
echo "Total lines of code (excluding comments and empty lines): $total_lines"

