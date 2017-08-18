ifeq ($(DOCKER_ARCH),armhf)
	DOCKER_IMAGE_NAME := tenstartups/ser2sock:armhf
else
	DOCKER_ARCH := x64
	DOCKER_IMAGE_NAME := tenstartups/ser2sock:latest
endif

build: Dockerfile.$(DOCKER_ARCH)
	docker build --file Dockerfile.$(DOCKER_ARCH) --tag $(DOCKER_IMAGE_NAME) .

clean_build: Dockerfile.$(DOCKER_ARCH)
	docker build --no-cache --pull --file Dockerfile.$(DOCKER_ARCH) --tag $(DOCKER_IMAGE_NAME) .

run: build
	docker run -it --rm \
	  --device /dev/ttyS0 \
		-p 10000:10000 \
		-v /etc/localtime:/etc/localtime \
		-e VIRTUAL_HOST=ser2sock.docker \
		-e LISTENER_PORT=10000 \
	  -e SERIAL_DEVICE=/dev/ttyS0 \
	  -e BAUD_RATE=115200 \
		--name ser2sock \
		$(DOCKER_IMAGE_NAME) $(ARGS)

push: build
	docker push $(DOCKER_IMAGE_NAME)
