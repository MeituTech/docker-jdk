FROM ubuntu:20.04

LABEL maintainer="Ligboy.Liu <ligboy@gmail.com>"

# Environments
# - Language
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"

# ------------------------------------------------------
# --- Base pre-installed tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && apt-get install -y \
    language-pack-en \
    curl \
    debconf-utils \
    git \
    mercurial \
    python \
    software-properties-common \
    sudo \
    software-properties-common \
    tree \
    unzip \
    wget \
    zip \
    gcc-multilib \
    g++-multilib \
    zlib1g \
    lib32z1 \
    libc6-dev-i386 \
    build-essential \
    rsync \
    openjdk-11-jdk \
    && locale-gen en_US.UTF-8 \
    && apt-get clean -y && apt-get autoremove -y && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

# ------------------------------------------------------
# --- SSH config
RUN mkdir -p /root/.ssh
COPY ./ssh/config /root/.ssh/config

# ------------------------------------------------------
# --- Git config
RUN git config --global user.email robot@meitu.com && git config --global user.name "Meitu Robot"

# ------------------------------------------------------
# --- Android Debug Keystore
#RUN mkdir -p /root/.android
#COPY ./android/debug.keystore /root/.android/debug.keystore


# Go to workspace
RUN mkdir -p /var/workspace
WORKDIR /var/workspace
