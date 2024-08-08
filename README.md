# ft_onion
Introductory project allowing the implementation of a hidden service on tor.


## Estrutura do Projeto
```
ft_onion/
.
├── Makefile
├── README.md
├── dockerfile
├── roteiro.md
└── src
    ├── cpf-generator.html
    ├── index.html
    ├── init.sh
    ├── js
    │   └── cpf-generator.js
    ├── nginx.conf
    ├── ssh_banner
    ├── sshd_config
    ├── test_onion.sh
    └── torrc
```

## 


## Como Usar

Construir a Imagem Docker:

```sh
docker build -t ft_onion -f dockerfile .
```

Remover o Contêiner Existente (se houver):

```sh
docker stop ft_onion-container
docker rm ft_onion-container
```

Rodar o Contêiner:
```sh

docker run -d -p 80:80 -p 4242:4242 --name ft_onion-container
```


Verificar o Endereço .onion:
```sh

make hostname
```



## SSH

ssh -o ProxyCommand="nc -x 127.0.0.1:9050 %h %p" -p 4242 caalbert@7jjh45mjl2v7crzahxmqbnyird6a52hkvn7zvdiho43z7ttsfs3lsrad.onion