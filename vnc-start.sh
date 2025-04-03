#!/bin/bash
whoami
vncserver -passwd /home/user/.vnc/passwd :1  && websockify --web /usr/share/novnc/ 6080 localhost:5901
