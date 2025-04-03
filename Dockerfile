# Use Ubuntu 22.04 as the base image
FROM ubuntu:17.04

# Set non-interactive frontend to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

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
    tigervnc-standalone-server \
    python3-pip python3-websockify python3 

USER root
# Set up a user
RUN adduser --disabled-password --gecos "" user && \
    echo "user:password" | chpasswd && \
    adduser user sudo && \
    echo "xfce4-session" > /home/user/.xsession && \
    chown user:user /home/user/.xsession

# Set up a user as root
RUN usermod -aG sudo user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up VNC server
RUN mkdir -p /home/user/.vnc
RUN    echo "password" | vncpasswd -f > /home/user/.vnc/passwd
RUN    chown -R user:user /home/user/.vnc
RUN    chmod 0600 /home/user/.vnc/passwd

#RUN echo "#!/bin/bash\n\
#    dbus-launch --exit-with-session startxfce4 &" > /home/user/.vnc/xstartup && \
#    chmod +x /home/user/.vnc/xstartup

RUN vncserver -passwd /home/user/.vnc/passwd :1 &

# cài đặt chrome
RUN apt-get install -y xvfb libnss3 libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libstdc++6 libx11-6 libxcomposite1 libxdamage1 libxext6 libxfixes3 libxrandr2 libxrender1 libxss1 wget fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-liberation

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb
RUN apt --fix-broken install
# khi chạy chrome thì chạy bằng lệnh
# google-chrome-stable  --no-sandbox --disable-dev-shm-usage --disable-gpu --no-first-run --disable-fre --no-default-browser-check
# thì mới chạy đc trên linux

RUN git clone https://github.com/novnc/noVNC.git noVNC
RUN  chmod -R 777 /noVNC

# Expose web-based VNC port
EXPOSE 6080

COPY vnc-start.sh /vnc-start.sh
RUN  chmod 777 /vnc-start.sh

USER user
# Start noVNC with TigerVNC
CMD ["/vnc-start.sh"]
# CMD ["whoami"]
#CMD ["/bin/sh", "-c", "vncserver :1 -geometry 1280x720  && websockify --web /usr/share/novnc/ 6080 0.0.0.0:5901"]
