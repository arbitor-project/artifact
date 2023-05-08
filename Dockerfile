FROM nvidia/cuda:11.0.3-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN cp -P /usr/include/cudnn* /usr/local/cuda/include
RUN cp -P /usr/lib/x86_64-linux-gnu/libcudnn* /usr/local/cuda/lib64

ARG ROOTDIR=/root/arbitor_artifact

RUN apt-get update && apt-get install -yq wget build-essential libssl-dev cmake python3-dev python3.8-venv python-is-python3 git clang++-11 ninja-build
RUN ln -s /usr/bin/clang++-11 /usr/bin/clang++
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