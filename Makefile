.PHONY: helping hand

USER=lmestar
IMAGE=$(USER)/sample-go-app
CONTAINER_NAME=go-app
PORT=5200

all: build run

build:
	docker build -t $(IMAGE) .

run:
	docker run -it --rm --name $(CONTAINER_NAME) -e ECHO="Hello world" -d -p $(PORT):$(PORT) $(IMAGE)

stop:
	docker stop $(CONTAINER_NAME) || docker service rm $(CONTAINER_NAME)

push:
	docker push $(IMAGE)

swarm: build push
	docker service create \
		--name=$(CONTAINER_NAME) \
		--replicas 3 \
		--env ECHO="Hello world" \
		-p $(PORT):$(PORT) \
		--detach=true \
		$(IMAGE)

update:
	# USAGE: make update echo='hi'
	docker service update --env-add ECHO="$(echo)" $(CONTAINER_NAME)

scale:
	# USAGE: make scale n=5
	docker service scale $(CONTAINER_NAME)=$(n)
