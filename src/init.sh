#!/bin/bash

# Iniciar SSH
echo "Starting SSH service..."
service ssh start

# Verificar configuração do Nginx
echo "Checking Nginx configuration..."
nginx -t
if [ $? -ne 0 ]; then
  echo "Nginx configuration error. Exiting..."
  exit 1
fi

# Iniciar Nginx
echo "Starting Nginx service..."
service nginx start

# Iniciar Tor
echo "Starting Tor service..."
service tor start

# Verificar se o diretório do serviço oculto foi criado
if [ ! -f /var/lib/tor/hidden_service/hostname ]; then
  echo "Tor did not create the hidden service directory. Exiting..."
  exit 1
fi

# Manter o contêiner rodando
echo "All services started. Keeping the container running..."
tail -f /dev/null
