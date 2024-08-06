DOCKER_IMAGE = ft_onion
DOCKER_CONTAINER = ft_onion-container

all: docker-build

docker-build: docker-stop docker-clean
	docker build -t $(DOCKER_IMAGE) -f dockerfile .

docker-run:
	docker run -d -p 80:80 -p 4242:4242 --name $(DOCKER_CONTAINER) $(DOCKER_IMAGE)

docker-clean:
	docker rmi -f $(DOCKER_IMAGE) || true

docker-stop:
	docker stop $(DOCKER_CONTAINER) || true
	docker rm $(DOCKER_CONTAINER) || true

docker-prune: docker-stop docker-clean
	docker system prune -f

run: docker-build docker-run

hostname:
	docker exec -it $(DOCKER_CONTAINER) cat /var/lib/tor/hidden_service/hostname

.PHONY: all build docker-build docker-run docker-clean docker-stop docker-prune run hostname
