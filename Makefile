APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := jasson-axe
GHCR_REGISTRY := ghcr.io
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64 
TAG := ${VERSION}-${TARGETOS}-${TARGETARCH}

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/Jasson-AXE/kbot/cmd.appVersion=${VERSION}

image:
    # docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
	docker build . -t ${GHCR_REGISTRY}/${REGISTRY}/${APP}:${TAG} --build-arg TARGETARCH=${TARGETARCH}

push:
    # docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
	docker push ${GHCR_REGISTRY}/${REGISTRY}/${APP}:${TAG}

clean:
	rm -rf kbot
	docker rmi ${GHCR_REGISTRY}/${REGISTRY}/${APP}:${TAG}