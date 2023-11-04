#!/bin/bash

ROOT_DIR="$(dirname "${BASH_SOURCE[0]}")/.."

SCRIPT="$ROOT_DIR/scripts/line_counter.sh"

function test_no_arguments() {
  assert_equals "Usage: $SCRIPT <venv_name> <file_extensions>" "$($SCRIPT)"
}

# TODO: more tests