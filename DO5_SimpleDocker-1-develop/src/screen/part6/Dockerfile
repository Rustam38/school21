FROM nginx
WORKDIR /home/
COPY ./mini_server.c .
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./run.sh .
RUN apt-get update && apt-get install -y \
    gcc \
    spawn-fcgi \
    libfcgi-dev \
    && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["sh", "./run.sh"]
