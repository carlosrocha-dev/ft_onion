# ft_onion
Introductory project allowing the implementation of a hidden service on tor.


## Estrutura do Projeto

ft_onion/
.
├── Makefile
├── README.md
├── dockerfile
└── src
	├── cpf-generator.html
	├── index.html
	├── js
	│	└── cpf-generator.js
	├── nginx.conf
└── torrcl



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

