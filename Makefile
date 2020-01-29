VERSION=3.8.0
.PHONY: proto-clean
proto-clean:
	@(rm -rf pb/*)
.PHONY: proto
proto: proto-clean
	@(docker run --rm -v ${PWD}:/src protobuf protoc -I/src/proto --go_out=/src/pb/ event.proto)
.PHONY: docker-update
docker-update:
	@(docker run --rm -v ${PWD}:/src -it ubuntu:18.04 /bin/sh /src/docker/protobuf/update.sh)
	$(MAKE) docker-build
.PHONY: docker-build
docker-build:
	@(docker build -t protobuf docker/protobuf)
docker-clean:
	@(rm -rf docker/protobuf/*)
.PHONY: docker-push
docker-push: docker-build 
	@(docker tag protobuf xackery/protobuf:$(VERSION))
	@(docker push xackery/protobuf:$(VERSION))