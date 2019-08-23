VERSION:= 4.2.2
.PHONY: all build push

all: build push

build:
	DOKCER_BUILDKIT=1 docker build . --build-arg VERSION=$(VERSION)  -t mimuret/nsd:$(VERSION) -t mimuret/nsd:latest

push:
	docker push mimuret/nsd:$(VERSION)
	docker push mimuret/nsd:latest