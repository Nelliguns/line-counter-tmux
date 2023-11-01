#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file_endings> <directory_to_ignore>"
    exit 1
fi

# Assign the arguments to variables
file_endings="$1"
folder_name="$2"
start_dir="$(tmux display-message -p '#{pane_current_path}')"

# Initialize a variable to store the total lines of code
total_lines=0

# Function to process files
process_file() {
  file="$1"
  lines=$(wc -l < "$file")
  total_lines=$((total_lines + lines))
}

# Recursively find and process files while excluding directories with the specified folder name
find "$start_dir" -type d -name "$folder_name" -prune -o -type f -print | while read -r file; do
  # Check if the file matches the specified file endings
  if echo "$file" | grep -Eq "\\.($file_endings)$"; then
    process_file "$file"
  fi
done

# Display the total lines of code found
echo "Total lines of code: $total_lines"
