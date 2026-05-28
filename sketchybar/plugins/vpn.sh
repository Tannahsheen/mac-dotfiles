#!/bin/sh

CYAN=0xff7dcfff
DIM=0xff627e97

# Try utun5 first (Tailscale default), fall back to any 100.x address
IP=$(ipconfig getifaddr utun5 2>/dev/null)
[ -z "$IP" ] && IP=$(ifconfig 2>/dev/null | awk '/inet 100\./{print $2}' | head -1)

if [ -n "$IP" ]; then
  sketchybar --set "$NAME" icon.color=$CYAN label.color=$CYAN label="vpn: $IP"
else
  sketchybar --set "$NAME" icon.color=$DIM label.color=$DIM label="vpn: --"
fi
