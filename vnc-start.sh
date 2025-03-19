#!/bin/bash
whoami
vncserver -passwd /home/user/.vnc/passwd :1  && websockify --web /usr/share/novnc/ 6080 0.0.0.0:5901
