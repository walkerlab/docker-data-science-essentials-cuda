# Docker Data Science Essentials with CUDA

A Docker image based on NVIDIA CUDA 13.1.0 with Ubuntu 24.04, pre-configured with essential data science libraries and tools.

## Base Image
- **CUDA Version**: 13.1.0 (runtime)
- **Ubuntu Version**: 24.04

## Included Python Libraries
- numpy
- scipy
- scikit-learn
- pandas
- matplotlib
- seaborn
- numpyro
- pymc
- jax (with CUDA support)

## System Tools
- build-essential
- software-properties-common
- curl
- git
- wget
- vim
- zip/unzip
- fish shell

## Package Management
- **Python Package Manager**: uv (with pip)
- **Python Environment**: Virtual environment at `/venv`

## Maintainers
- Daniel Sitonic <danielsitonic@gmail.com>

## Working Directory
- `/src`