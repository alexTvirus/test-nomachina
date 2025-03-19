#!/bin/bash
whoami
sudo vncserver -SecurityTypes VncAuth -rfbauth /home/user/.vnc/passwd -geometry 1280x720  && sudo websockify --web /usr/share/novnc/ 6080 0.0.0.0:5901
