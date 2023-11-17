VERSION:

format:
	gofmt -s -w ./

build:
	go build -v -o kbot -ldflags "-X="github.com/Jasson-AXE/kbot/cmd.appVersion=${VERSION}