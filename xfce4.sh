#!/bin/bash

/etc/NX/nxserver --startup

git clone https://github.com/alexTvirus/wstunel-client.git

git clone https://github.com/alexTvirus/lite-http-tunnel-client.git

bash /lite-http-tunnel-client/lite-http-tunnel config server https://neighborly-tungsten-microwave.glitch.me/
bash /lite-http-tunnel-client/lite-http-tunnel auth abc abc
bash /lite-http-tunnel-client/lite-http-tunnel start 9998

bash /wstunel-client/wstunnel -s 0.0.0.0:9998 -t 0.0.0.0:4000

#echo "Go to: https://dashboard.ngrok.com/get-started/your-authtoken"

#./ngrok authtoken 2AI2NdKMqKHeyBUXc6rkrySdU0i_89bYasgZt35Zz3NB2fjwj

# https://github.com/alexTvirus/Docker-Ubuntu-Desktop-NoMachine
#echo "Repo: https://github.com/alexTvirus/Docker-Ubuntu-Desktop-NoMachine"

#./ngrok tcp --region us 4000 &>/dev/null &
#sleep 15

#echo "NoMachine: https://www.nomachine.com/download"
#echo Done! NoMachine Information:
#echo IP Address:
#curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' 
#echo User: user
#echo Passwd: 123456
#echo "VM can't connect? Restart Cloud Shell then Re-run script."




#seq 1 43200 | while read i; do echo -en "\r Running .     $i s /43200 s";sleep 0.1;echo -en "\r Running ..    $i s /43200 s";sleep 0.1;echo -en "\r Running ...   $i s /43200 s";sleep 0.1;echo -en "\r Running ....  $i s /43200 s";sleep 0.1;echo -en "\r Running ..... $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1;echo -en "\r Running  .... $i s /43200 s";sleep 0.1;echo -en "\r Running   ... $i s /43200 s";sleep 0.1;echo -en "\r Running    .. $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1; done
