FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    nginx \
    openssh-server \
    tor \
    netcat \
    make \
    && rm -rf /var/lib/apt/lists/*

COPY src/nginx.conf /etc/nginx/nginx.conf
COPY src/index.html /var/www/html/index.html
COPY src/cpf-generator.html /var/www/html/cpf-generator.html
COPY src/js/cpf-generator.js /var/www/html/js/cpf-generator.js

COPY src/sshd_config /etc/ssh/sshd_config
COPY src/ssh_banner /etc/ssh/ssh_banner

ARG SSH_USER
ARG SSH_PASSWORD

RUN useradd -ms /bin/bash $SSH_USER && \
    echo "$SSH_USER:$SSH_PASSWORD" | chpasswd

COPY src/torrc /etc/tor/torrc

RUN mkdir -p /var/lib/tor/hidden_service && \
    chown -R debian-tor:debian-tor /var/lib/tor/hidden_service && \
    chmod 700 /var/lib/tor/hidden_service

RUN mkdir -p /var/log/tor && \
    chown -R debian-tor:debian-tor /var/log/tor && \
    chmod 700 /var/log/tor

RUN mkdir -p /var/log/nginx

EXPOSE 80 4242

COPY Makefile /app/Makefile

WORKDIR /app

COPY src/init.sh /app/init.sh
RUN chmod +x /app/init.sh

COPY src/test_onion.sh /app/test_onion.sh
RUN chmod +x /app/test_onion.sh

ENTRYPOINT ["/app/init.sh"]
