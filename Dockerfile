FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWORD=India@01
ENV RESOLUTION=1280x720
ENV USER=root
ENV HOME=/root

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    tightvncserver \
    novnc websockify \
    dbus-x11 x11-xserver-utils \
    firefox \
    wget curl sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

RUN mkdir -p /root/.vnc && \
    printf '#!/bin/bash\nxrdb $HOME/.Xresources\nstartxfce4 &\n' > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

RUN printf '#!/bin/bash\nset -e\nexport USER=root\nexport HOME=/root\nmkdir -p /root/.vnc\necho "$VNC_PASSWORD" | vncpasswd -f > /root/.vnc/passwd\nchmod 600 /root/.vnc/passwd\nvncserver -kill :1 >/dev/null 2>&1 || true\nrm -rf /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null || true\nvncserver :1 -geometry "$RESOLUTION" -depth 24\nwebsockify --web=/usr/share/novnc/ "${PORT:-6080}" localhost:5901\n' > /start.sh && \
    chmod +x /start.sh

EXPOSE 6080

CMD ["/start.sh"]
