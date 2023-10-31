#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKING_DIR=$(pwd)
FILE_ENDINGS="py"
tmux bind-key T run-shell "$CURRENT_DIR/scripts/line_counter.sh $(tmux display-message -p '#{pane_current_path}') $FILE_ENDINGS"
