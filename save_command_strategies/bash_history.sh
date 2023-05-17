#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PANE_PID="$1"
SESSION_NAME="$2"
WINDOW_NUMBER="$3"
PANE_INDEX="$4"

exit_safely_if_empty_ppid() {
	if [ -z "$PANE_PID" ]; then
		exit 0
	fi
}

full_command() {
	RUNNING="$(ps -ao "ppid,args" |
		sed "s/^ *//" |
		grep "^${PANE_PID}" |
    cut -d' ' -f2-)"

  if [ -z "$RUNNING" ]; then
    exit 0
  fi

  FILE="$HOME/.bash_history.d/bash_cmd_tmux_${SESSION_NAME}:${WINDOW_NUMBER}:${PANE_INDEX}"

  if [ ! -f "$FILE" ]; then
    exit 0
  fi

  CMD="$(tail -n 1 "$FILE")"

  if [ -z "$CMD" ]; then
    exit 0
  fi

  echo "$CMD"
}

main() {
	exit_safely_if_empty_ppid
	full_command
}
main
