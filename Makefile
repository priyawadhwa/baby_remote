all: build
.PHONY: all

REPO ?=
GO_LDFLAGS := '-extldflags "-static"
GO_LDFLAGS += -X $(VERSION_PACKAGE).version=$(VERSION)
GO_LDFLAGS += -w -s # Drop debugging symbols.
GO_LDFLAGS += '

build:
	go build -o _output/bin/image-whitelist-server github.com/tejal29/baby_remote/imagewhitelistserver
.PHONY: build

build-image:
	GOOS=linux CGO_ENABLED=0 go build -ldflags $(GO_LDFLAGS) -o _output/bin/image-whitelist-server github.com/tejal29/baby_remote/imagewhitelistserver
	hack/build-image.sh
.PHONY: build-image

push-image:
	docker push gcr.io/priya-wadhwa/image-whitelist-server:latest

clean:
	rm -rf _output
.PHONY: clean
