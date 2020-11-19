
Usage:

Assuming proto files input is ${ROOT_REPO}/proto, and output is ${ROOT_REPO}/src/pb/v1

in Makefile:
```makefile
PROTO_VERSION=3.14.0
PROTO_LOCAL_VERSION := v1
PROTO_FILES := $(shell find proto -name '*.proto')
PROTO_OUT := src/pb/$(PROTO_LOCAL_VERSION)
PROTO_CS_OUT := src/pb/cs/$(PROTO_LOCAL_VERSION)
.PHONY: proto-clean
proto-clean:
	@echo "removing generated contents..."
	@rm -rf src/pb/v1/*.pb.*go
.PHONY: proto
proto: proto-clean ## Generate protobuf files
	@echo "proto > pb"
	@mkdir -p $(PROTO_OUT)
	@mkdir -p $(PROTO_CS_OUT)
	@docker run --rm -v ${PWD}/$(PROTO_OUT):/out/ -v ${PWD}/$(PROTO_CS_OUT):/cs/ -v ${PWD}:/src xackery/protobuf:$(PROTO_VERSION) protoc \
	-I/protobuf/src \
	-I/src \
	-I/grpc \
	-I/grpc/third_party/googleapis \
	$(PROTO_FILES) \
	--go_out /out/ \
	--go_opt=paths=source_relative \
	--go-grpc_out /out/ \
	--go-grpc_opt=paths=source_relative \
	--grpc-gateway_out /out/ \
	--grpc-gateway_opt=paths=source_relative \
	--grpc-gateway_opt generate_unbound_methods=true \
	--openapiv2_out /out \
	--openapiv2_opt logtostderr=true \
	--csharp_out /cs
	@mv src/pb/$(PROTO_LOCAL_VERSION)/proto/* $(PROTO_OUT)
	@rm -rf src/pb/$(PROTO_LOCAL_VERSION)/proto
	@mkdir -p swagger/
	@mv src/pb/$(PROTO_LOCAL_VERSION)/*.json swagger/
```