# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

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
    novnc \
    websockify \
    tigervnc-standalone-server && \
    apt-get clean

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

# Expose web-based VNC port
EXPOSE 6080

COPY vnc-start.sh /vnc-start.sh
RUN  chmod 777 /vnc-start.sh

USER user
# Start noVNC with TigerVNC
CMD ["/vnc-start.sh"]
# CMD ["whoami"]
#CMD ["/bin/sh", "-c", "vncserver :1 -geometry 1280x720  && websockify --web /usr/share/novnc/ 6080 0.0.0.0:5901"]
