# Image Args
ARG UBUNTU_VER
ARG CUDA_VER

FROM nvidia/cuda:${CUDA_VER}-runtime-ubuntu${UBUNTU_VER}
LABEL maintainer="Edgar Y. Walker <eywalker@uw.edu>, Daniel Sitonic <sitonic@uw.edu>"

# Deal with pesky Python 3 encoding issue
ENV LANG=C.UTF-8

# Prevent Debian/Ubuntu from asking questions
ENV DEBIAN_FRONTEND=noninteractive

RUN rm -rf /usr/share/dotnet && rm -rf "$AGENT_TOOLSDIRECTORY"
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

RUN JAX_CUDA_VER = ${CUDA_VER:0:2} | \
    pip3 install \
    numpy \
    scipy \ 
    scikit-learn \
    pandas \
    matplotlib \ 
    seaborn \
    jax[cuda$JAX_CUDA_VER_local] -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html \ 
    numpyro \
    pymc
    
WORKDIR /src