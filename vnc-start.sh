#!/bin/bash
whoami
vncserver -passwd /home/user/.vnc/passwd :1  && ./noVNC/utils/novnc_proxy --vnc 127.0.0.1:5901 --listen 0.0.0.0:6080
