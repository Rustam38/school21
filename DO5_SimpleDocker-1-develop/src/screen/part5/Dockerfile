FROM nginx
WORKDIR /home/
COPY ./mini_server.c .
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./run.sh .
RUN apt-get update && apt-get install -y gcc spawn-fcgi libfcgi-dev 
ENTRYPOINT ["sh", "./run.sh"]
