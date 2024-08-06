FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    nginx \
    openssh-server \
    tor \
    make \
    && rm -rf /var/lib/apt/lists/*

COPY src/nginx.conf /etc/nginx/nginx.conf
COPY src/index.html /var/www/html/index.html
COPY src/cpf-generator.html /var/www/html/cpf-generator.html
COPY src/js/cpf-generator.js /var/www/html/js/cpf-generator.js

COPY src/sshd_conf /etc/ssh/sshd_config

COPY src/torrcl /etc/tor/torrc

RUN mkdir -p /var/lib/tor/hidden_service && chown -R debian-tor:debian-tor /var/lib/tor/hidden_service && chmod 700 /var/lib/tor/hidden_service

RUN mkdir -p /var/log/nginx

EXPOSE 80 4242

COPY Makefile /app/Makefile

WORKDIR /app

RUN make build

COPY src/init.sh /app/init.sh
RUN chmod +x /app/init.sh

ENTRYPOINT ["/app/init.sh"]