FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWORD=changeme123
ENV RESOLUTION=1280x720

RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies \
    tightvncserver \
    novnc websockify \
    dbus-x11 x11-xserver-utils \
    firefox \
    wget curl sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# noVNC ko web root pe set karo
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# VNC startup script
RUN mkdir -p /root/.vnc
COPY xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080

CMD ["/start.sh"]
