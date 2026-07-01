#!/bin/bash
set -e

# VNC password set karo (env var VNC_PASSWORD se)
mkdir -p /root/.vnc
echo "$VNC_PASSWORD" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Purana lock/session hata do agar hai
vncserver -kill :1 >/dev/null 2>&1 || true
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null || true

# VNC server start karo
vncserver :1 -geometry "$RESOLUTION" -depth 24

# noVNC ko Railway ke assigned $PORT par chalao (default 6080)
websockify --web=/usr/share/novnc/ "${PORT:-6080}" localhost:5901
