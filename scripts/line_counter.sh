#!/bin/bash

# Check for correct number of arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <venv_name> <file_extensions>"
    exit 1
fi

# Set the virtual environment name
venv_name="$1"

# Split the provided file_extensions argument into an array
IFS=',' read -ra file_extensions <<< "$2"

# Set the directory to the current path of the tmux pane
directory="$(tmux display-message -p '#{pane_current_path}')"

# Initialize an associative array to store lines per extension
declare -A lines_per_extension

# Loop through the provided file extensions
for extension in "${file_extensions[@]}"; do
    lines_per_extension["$extension"]=0  # Initialize lines count to 0 for this extension
done

# Use 'find' to locate files and count their lines for each extension
while IFS= read -r -d '' file; do
    # Check if the file is outside the virtual environment directory
    if [[ "$file" != "$directory/$venv_name"* ]]; then
        for extension in "${file_extensions[@]}"; do
            if [[ "$file" == *".$extension" ]]; then
                # Count non-empty lines (ignoring lines that contain only whitespace)
                lines=$(grep -v '^[[:space:]]*$' "$file" | wc -l)
                lines_per_extension["$extension"]=$((lines_per_extension["$extension"] + lines))
            fi
        done
    fi
done < <(find "$directory" -type f -print0)

# Print the lines of code for each extension
for extension in "${file_extensions[@]}"; do
    echo "Total lines of code for .$extension files (excluding empty lines and files in $venv_name directory): ${lines_per_extension["$extension"]}"
done

