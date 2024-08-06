# Usar uma imagem base mínima do Debian Bullseye Slim
FROM debian:bullseye-slim

# Instalar pacotes necessários
RUN apt-get update && apt-get install -y \
    nginx \
    openssh-server \
    tor \
    make \
    && rm -rf /var/lib/apt/lists/*

# Configurar Nginx
COPY src/nginx.conf /etc/nginx/nginx.conf
COPY src/index.html /var/www/html/index.html
COPY src/cpf-generator.html /var/www/html/cpf-generator.html
COPY src/js/cpf-generator.js /var/www/html/js/cpf-generator.js

# Configurar SSH
COPY src/sshd_conf /etc/ssh/sshd_config

# Configurar Tor
COPY src/torrcl /etc/tor/torrc

# Criar diretório necessário para o serviço Tor
RUN mkdir -p /var/lib/tor/hidden_service && chown -R debian-tor:debian-tor /var/lib/tor/hidden_service && chmod 700 /var/lib/tor/hidden_service

# Criar diretório para o Nginx logs
RUN mkdir -p /var/log/nginx

# Expor portas
EXPOSE 80 4242

# Copiar Makefile
COPY Makefile /app/Makefile

# Definir diretório de trabalho
WORKDIR /app

# Executar o Makefile
RUN make build

# Script de inicialização para garantir que todos os serviços estejam rodando
COPY src/init.sh /app/init.sh
RUN chmod +x /app/init.sh

ENTRYPOINT ["/app/init.sh"]