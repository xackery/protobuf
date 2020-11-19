PROTOC=3.14.0
apt-get update && apt-get -y upgrade
apt-get install -y git golang unzip wget
wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC}/protoc-${PROTOC}-linux-x86_64.zip
unzip protoc-${PROTOC}-linux-x86_64.zip
chmod +x /bin/protoc
/bin/cp /bin/protoc /src/docker/protobuf/
export GOBIN=/bin
go get -u github.com/grpc-ecosystem/grpc-gateway
go get -u google.golang.org/protobuf/cmd/protoc-gen-go
go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
cd /root/go/src/github.com/grpc-ecosystem/grpc-gateway/ && go get ./...
go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-openapiv2
/bin/cp /bin/protoc-gen-go /src/docker/protobuf/
/bin/cp /bin/protoc-gen-grpc-gateway /src/docker/protobuf/
/bin/cp /bin/protoc-gen-go-grpc /src/docker/protobuf/
/bin/cp /bin/protoc-gen-openapiv2 /src/docker/protobuf/