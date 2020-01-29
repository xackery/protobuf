FROM ubuntu:18.04

RUN apt-get -y update && apt-get install -y \
	git

COPY protoc /usr/bin/protoc
COPY protoc-gen-grpc-gateway /bin/protoc-gen-grpc-gateway
COPY protoc-gen-swagger /bin/protoc-gen-swagger
COPY protoc-gen-go /bin/protoc-gen-go

RUN git clone --branch v1.3.2 https://github.com/golang/protobuf.git /golangproto
RUN git clone https://github.com/googleapis/googleapis.git /googleapis
RUN git clone --branch v1.9.0 https://github.com/grpc-ecosystem/grpc-gateway.git /grpc
RUN git clone --branch v3.8.0 https://github.com/protocolbuffers/protobuf.git /protobuf
#used in C++ use cases
#COPY protobuf/src /protobuf
#COPY libprotobuf.so.17 /usr/lib/libprotobuf.so.17
#COPY libprotoc.so.17 /usr/lib/libprotoc.so.17
#RUN echo “/usr/lib/libprotobuf.so.17” > /etc/ld.so.conf.d/libprotobuf.conf
#RUN echo “/usr/lib/libprotoc.so.17" >> /etc/ld.so.conf.d/libprotobuf.conf
#RUN ldconfig

ENV HOME /src
WORKDIR /src


# Define default command.
CMD [“protoc”]