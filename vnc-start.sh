#!/bin/bash
whoami

# cài đặt nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf '%s/.nvm' "${HOME}" || printf '%s/nvm' "${XDG_CONFIG_HOME}")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash completion
nvm install 14
nvm use 14

# --------------------- test voi lite-tunel seft host

git clone https://github.com/alexTvirus/wstunel-client.git

vncserver -passwd /home/user/.vnc/passwd :1  &

bash /wstunel-client/wstunnel -s 0.0.0.0:7860 -t 127.0.0.1:5901

# -------------------

# websockify --web /usr/share/novnc/ 6080 127.0.0.1:5901 &
