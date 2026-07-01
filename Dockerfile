FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWORD=India@01
ENV RESOLUTION=1280x720
ENV HOME=/root

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    xvfb x11vnc \
    novnc websockify \
    dbus-x11 x11-xserver-utils \
    firefox \
    wget curl sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

RUN mkdir -p /root/.vnc

RUN printf '#!/bin/bash\nset -e\nmkdir -p /root/.vnc\nx11vnc -storepasswd "$VNC_PASSWORD" /root/.vnc/passwd\nrm -f /tmp/.X1-lock\nXvfb :1 -screen 0 "${RESOLUTION}x24" &\nsleep 2\nexport DISPLAY=:1\nstartxfce4 &\nsleep 2\nx11vnc -display :1 -forever -shared -rfbauth /root/.vnc/passwd -bg -o /var/log/x11vnc.log\nwebsockify --web=/usr/share/novnc/ "${PORT:-6080}" localhost:5900\n' > /start.sh && \
    chmod +x /start.sh

EXPOSE 6080

CMD ["/start.sh"]
