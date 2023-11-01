#!/bin/bash
# "$(tmux display-message -p '#{pane_current_path}')"
# #!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file_endings> <directory_to_ignore>"
    exit 1
fi

file_endings="$1"
current_directory="$(tmux display-message -p '#{pane_current_path}')"
directory_to_ignore="$2"
lines_of_code=0

#!/bin/bash

# Check for correct number of arguments
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <file_extensions...> <venv_name>"
    exit 1
fi

# Set the directory to search in
directory="$(tmux display-message -p '#{pane_current_path}')"

# Set the virtual environment name
venv_name="$2"

# Remove the first two arguments (directory and venv_name) to get the file extensions
shift 2

# Initialize a variable to store the total lines of code
total_lines=0

# Loop through the provided file extensions
for extension in "$1"; do
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
echo "Total lines of code (excluding empty lines and files in $venv_name directory): $total_lines"

