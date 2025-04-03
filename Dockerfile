# Use selenium/standalone-chrome:90.0.4430.85
FROM selenium/standalone-chrome:90.0.4430.85

# Set non-interactive frontend to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

USER root
# Install necessary packages
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xfce4-terminal \
    xdotool \
    sudo \
    wget \
    git \
    nano \
    dbus-x11 \
    xauth \
    novnc \
    websockify \
    tigervnc-standalone-server && \
    apt-get clean


# Set up a user
RUN echo "seluser:password" | chpasswd && \
    adduser seluser sudo && \
    echo "xfce4-session" > /home/seluser/.xsession && \
    chown seluser:seluser /home/seluser/.xsession

# Set up a user as root
RUN usermod -aG sudo seluser
RUN echo "seluser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up VNC server
RUN mkdir -p /home/seluser/.vnc
RUN    echo "123456" | vncpasswd -f > /home/seluser/.vnc/passwd
RUN    chown -R seluser:seluser /home/seluser/.vnc
RUN    chmod 0600 /home/seluser/.vnc/passwd

RUN echo "#!/bin/bash\n\
   dbus-launch --exit-with-session startxfce4 &" > /home/seluser/.vnc/xstartup && \
   chmod +x /home/seluser/.vnc/xstartup

RUN vncserver -passwd /home/seluser/.vnc/passwd :1 &

# khi chạy chrome thì chạy bằng lệnh
# google-chrome-stable  --no-sandbox --disable-dev-shm-usage --disable-gpu --no-first-run --disable-fre --no-default-browser-check
# thì mới chạy đc trên linux

# Expose web-based VNC port
EXPOSE 6080

COPY vnc-start.sh /vnc-start.sh
RUN  chmod 777 /vnc-start.sh

USER seluser
# Start noVNC with TigerVNC
CMD ["/vnc-start.sh"]
# CMD ["whoami"]
#CMD ["/bin/sh", "-c", "vncserver :1 -geometry 1280x720  && websockify --web /usr/share/novnc/ 6080 0.0.0.0:5901"]
