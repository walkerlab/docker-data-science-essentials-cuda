# Image Args
ARG UBUNTU_VER=24.04
ARG CUDA_VER=12.8.1
FROM nvidia/cuda:${CUDA_VER}-runtime-ubuntu${UBUNTU_VER}
LABEL maintainer="Edgar Y. Walker <eywalker@uw.edu>, Daniel Sitonic <sitonic@uw.edu>"

# Deal with pesky Python 3 encoding issue
ENV LANG=C.UTF-8

# Prevent Debian/Ubuntu from asking questions
ENV DEBIAN_FRONTEND=noninteractive

# Make bash as default shell
SHELL ["/bin/bash", "-c"]

# Install essential Ubuntu packages
# and upgrade pip
RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y software-properties-common \
    git \
    wget \
    vim \
    curl \
    zip \
    unzip \
    fish \
    python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y python3-venv

RUN python3 -m venv /venv && \
    source /venv/bin/activate && \
    pip3 install \
        numpy \
        scipy \ 
        scikit-learn \
        pandas \
        matplotlib \ 
        seaborn \
        numpyro \
        pymc \
        jax[cuda$JAX_CUDA_VER_local] -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html 
    
WORKDIR /src