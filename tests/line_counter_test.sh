#!/bin/bash

ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."

SCRIPT="$ROOT_DIR/scripts/line_counter.sh"

function set_up(){
  mock tmux 'echo tests/fixtures'
}

function test_no_arguments() {
  assert_equals "Usage: $SCRIPT <venv_name> <file_extensions>" "$($SCRIPT)"
}

function test_one_argument() {
  assert_equals "Usage: $SCRIPT <venv_name> <file_extensions>" "$($SCRIPT fixtures)"
}

function test_one_file_extension() {
  assert_equals\
   "Total lines of code (excluding empty lines and files in env-1 directory): 7"\
   "$($SCRIPT 'env-1' txt)"
}

function test_multiple_file_extensions() {
  assert_equals\
   "Total lines of code (excluding empty lines and files in env-1 directory): 10"\
   "$($SCRIPT 'env-1' txt,csv)"
}
