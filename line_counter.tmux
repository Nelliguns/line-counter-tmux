#!/usr/bin/env bash
#
get_tmux_option() {
  local option="$1"
  local default="$2"
  local value=$(tmux show-option -gqv "$option")

  if [ -z "$value" ]
  then
    echo "$default"
  else
    echo "$value"
  fi
}

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
    local file_endings=$(get_tmux_option "@file_endings" "py")
    local env=$(get_tmux_option "@env", "venv")
    local run_command=$(get_tmux_option "@run_command" "F")
    tmux bind-key "$run_command" run-shell "$CURRENT_DIR/scripts/line_counter.sh $env $file_endings"

}
main
