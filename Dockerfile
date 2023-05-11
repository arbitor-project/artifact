FROM nvidia/cuda:11.0.3-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN cp -P /usr/include/cudnn* /usr/local/cuda/include
RUN cp -P /usr/lib/x86_64-linux-gnu/libcudnn* /usr/local/cuda/lib64

ARG ROOTDIR=/root/arbitor_artifact

RUN apt-get update && apt-get install -yq wget build-essential libssl-dev cmake python3-dev python3.8-venv gcc-8 g++-8 python-is-python3 git clang++-11 ninja-build gnuplot
RUN ln -s /usr/bin/clang++-11 /usr/bin/clang++
RUN rm /usr/bin/gcc
RUN rm /usr/bin/g++
RUN ln -s /usr/bin/gcc-8 /usr/bin/gcc
RUN ln -s /usr/bin/g++-8 /usr/bin/g++
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64

WORKDIR /root
RUN mkdir -p bin/
WORKDIR /root/bin
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.16.0/bazelisk-linux-amd64
RUN chmod +x bazelisk-linux-amd64
RUN mv bazelisk-linux-amd64 bazel
ENV PATH=/root/bin:$PATH

WORKDIR /root

ADD arbitor /root/arbitor
ADD native_half /root/native_half

ADD pytorch-cifar /root/pytorch-cifar
ADD qpytorch.sh /root/qpytorch.sh
ADD gnn.sh /root/gnn.sh
ADD e2e.sh /root/e2e.sh
ADD gnn.gp /root/gnn.gp
RUN mkdir results