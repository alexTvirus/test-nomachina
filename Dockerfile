# Sử dụng image Nginx chính thức từ Docker Hub
FROM 6011915/nomachine-ubuntu-desktop:xfce4

COPY ngrok /ngrok

COPY xfce4.sh /xfce4.sh

	
USER root

#RUN	mkdir -p /usr/NX/bin 

#RUN chmod -R 777 /usr/NX/bin

#RUN chmod -R 777 /usr/NX

#RUN chmod -R 0400 /usr/NX/etc/server.lic

#RUN	mkdir -p /etc/NX

#RUN chmod -R 777 /etc/NX

RUN chmod -R 777 /xfce4.sh

RUN chmod -R 777 /ngrok

# Expose port 80 để nhận request
#EXPOSE 4040

# Khởi động Nginx
#CMD ["/xfce4.sh"]
