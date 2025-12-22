# Image Args
ARG UBUNTU_VER=24.04
ARG CUDA_VER=13.1.0
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
    apt-get install -y build-essential software-properties-common curl git wget vim zip unzip fish && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"

RUN uv venv /venv && \
    source /venv/bin/activate && \
    uv pip install numpy scipy scikit-learn pandas matplotlib seaborn numpyro pymc jax[cuda$JAX_CUDA_VER_local] -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html 
    
WORKDIR /src