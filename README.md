# tmux-pane-flash

A tiny tmux plugin to set up a flashy visual effect highlighting the active pane on each focus switch via the tmux `pane-focus-in` event hook. Handy if you sometimes get disoriented in a maze of panes..

## Installation

You may make use of the well-known [tmux plugin manager](https://github.com/tmux-plugins/tpm) to pull this in by putting following line in your `.tmux.conf`:

```
set -g @plugin 'eMPee584/tmux-pane-flash'
```

Alternatively, you can manually clone the repository and use `run-shell […]/tmux-pane-flash/pane-flash.tmux` to set up the hook.

For now, it assumes no other competing hook being set up on this event, but this could easily be expanded to handle such a slightly more advanced use case.

### Note for non-linux users

This makes use of the standard `flock` utility to prevent multiple invocations to pile up when quickly switching panes and windows. The `-E0` (`--conflict-exit-code 0`) might not be available on unixoid systems other than linux.. PRs appreciated.

## Removal

Just remove the plugin line from your `.tmux.conf` and use `tmux set-hook -gu pane-focus-in` to unset the hook.

## Configuration

There are a couple variables which allow controlling the duration each color is displayed for and the sequence of colors itself.
The color change interval defaults to `0.05` s, with the color indicating whether `tmux` is running as root (RED color) or other user (GREEN color). You can easily override this by specifying the name of one of the four included presets to use, or a sequence of hex colors of your own choice.
Also, by default, the hook will not flash single-pane windows.

**To apply any changes set in this way, the `pane-flash.tmux` script has to be rerun**, as for performance reasons the variables are only read once during hook setup.

```
# Configuration Examples

# Slow it down a bit while you design your favorite color sequence
set -g @pane-flash-interval 0.4

# Unset preset to return to defaults
set -gu @pane-flash-preset

# Use the GRAY preset
set -g @pane-flash-preset "GRAY"

# Use a custom hex color sequence, f.e. a subtle CMY
set -g @pane-flash-preset "00cccc cc00cc cccc00"

# Flash pane even in windows with a single pane only
set -g @pane-flash-hook-cmd "\"run-shell -b 'flock --nonblock -E0 /run/lock/tmux-flash.\$(id -u) \$CWD/tmux-pane-flash \$interval \$preset'\""

# Testing how locking prevents multiple flash processes
set -g @pane-flash-hook-cmd "\"run-shell -b 'flock --nonblock /run/lock/tmux-flash.\$(id -u) \$CWD/tmux-pane-flash || beep'\""
```

## License

[MIT](LICENSE)
