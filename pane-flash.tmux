#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "$CURRENT_DIR/scripts/helpers.sh"

interval=$(get_tmux_option @tmux-pane-flash-interval "0.05")
preset=$(get_tmux_option @tmux-pane-flash-preset "")

# turn on focus-events
tmux set-option -g focus-events on

tmux set-hook -g pane-focus-in "run-shell -b 'flock --nonblock -E0 /run/lock/tmux-flash.$(id -u) $CURRENT_DIR/tmux-pane-flash $interval $preset'"
