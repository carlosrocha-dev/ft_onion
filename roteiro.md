# Como acessar o SSH via tor no projeto

1. Acesse o terminal interativo do container:

```sh
make test
```
 - será feita uma série de teste via shell para confirmar os pontos do subject:
 - A seguinte mensagem ir

```sh
	sleep 30 # Aguarde o Tor criar o diretório do serviço oculto
	docker exec -it ft_onion-container /app/test_onion.sh
	Verificando se o SSH está escutando na porta 4242...
	OK - SSH escutando na porta 4242
	Verificando configurações de segurança do SSH...
	OK - PermitRootLogin desabilitado
	OK - PasswordAuthentication habilitado
	OK - ChallengeResponseAuthentication desabilitado
	OK - UsePAM habilitado
	OK - X11Forwarding desabilitado
```

 - após essas verificaoes o terminal do contatiner ficará dispon;ivel e soliciratá uma senha para acessar o ssh via tor.
1. digite a senha:

```sh
Testando o prompt interativo SSH via Tor...
Warning: Permanently added '[endereço_onion_capturado_do_ambiente.onion]:4242' (ECDSA) to the list of known hosts.
***********************************************
*        Bem-vindo ao CPF Hidden SSH!         *
*           Você está conectado ao            *
*            servidor SSH via TOR             *
***********************************************
caalbert@<endereço_onion_capturado_do_ambiente>.onion's password:
```
