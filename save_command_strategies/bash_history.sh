#!/usr/bin/env bash

source ~/.rc-files/history_helpers.sh

SESSION_NAME="$2"
WINDOW_NUMBER="$3"
PANE_INDEX="$4"
WINDOW_NAME="$5"
PANE_ID="$6"

full_command() {
    local file
    file="$(getCmdFile "$PANE_ID" "$SESSION_NAME" "$WINDOW_NAME" "$WINDOW_NUMBER" "$PANE_INDEX")"

    if [ ! -f "$file" ]; then
        exit 0
    fi

    local cmd
    cmd="$(tail -n 1 "$file")"

    if [ -z "$cmd" ]; then
        exit 0
    fi

    echo "$cmd"
}

main() {
    full_command
}
main
