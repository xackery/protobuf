PROTOC=3.8.0
apt-get update && apt-get -y upgrade
apt-get install -y git golang unzip wget
wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC}/protoc-${PROTOC}-linux-x86_64.zip
unzip protoc-${PROTOC}-linux-x86_64.zip
chmod +x /bin/protoc
/bin/cp /bin/protoc /src/docker/protobuf/
export GOBIN=/bin
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
go get -u github.com/golang/protobuf/protoc-gen-go
/bin/cp /bin/protoc-gen-go /src/docker/protobuf/
/bin/cp /bin/protoc-gen-swagger /src/docker/protobuf/
/bin/cp /bin/protoc-gen-grpc-gateway /src/docker/protobuf/