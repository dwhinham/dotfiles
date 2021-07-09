#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

monitors=($(polybar --list-monitors | cut -d":" -f1))

# Launch bars
MONITOR=${monitors[0]} polybar --reload bar1 &
for m in ${monitors[@]:1}; do
	MONITOR=$m polybar --reload bar2 &
done
