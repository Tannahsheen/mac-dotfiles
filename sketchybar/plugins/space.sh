#!/bin/sh

CYAN=0xff7dcfff
ACTIVE_BG=0xff143652
INACTIVE_BG=0x22ffffff
DIM=0xff627e97

WS_NUM=$(echo "$NAME" | cut -d. -f2)
CURRENT=$(aerospace list-workspaces --focused 2>/dev/null)

if [ "$WS_NUM" = "$CURRENT" ]; then
  sketchybar --set "$NAME" \
    background.color=$ACTIVE_BG \
    icon.color=$CYAN
else
  sketchybar --set "$NAME" \
    background.color=$INACTIVE_BG \
    icon.color=$DIM
fi
