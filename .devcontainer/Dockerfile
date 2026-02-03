FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install basic dependencies
RUN apt-get update && \
    apt-get install -y curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
