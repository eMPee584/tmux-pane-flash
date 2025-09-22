#!/usr/bin/env bash
# Shell script to set flash as tmux pane-focus hook
# shellcheck disable=SC2034

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "$CWD/scripts/helpers.sh"

# to expand bash variables in the option string, eval is used when setting
# the hook and this requires a fair bit of escaping
hook_cmd=$(get_tmux_option @pane-flash-hook-cmd "\"run-shell -b '[ \\\$(tmux display-message -p #{window_panes}) -eq 1 ] || flock --nonblock -E0 /run/lock/tmux-flash.\$(id -u) \$CWD/tmux-pane-flash \$interval \$preset'\"")
interval=$(get_tmux_option @pane-flash-interval "0.05")
preset=$(get_tmux_option @pane-flash-preset "")

# turn on focus-events
tmux set-option -g focus-events on

# set up hook
eval tmux set-hook -g pane-focus-in "${hook_cmd}"
