FROM ubuntu:18.04

LABEL maintainer "Ligboy.Liu <ligboy@gmail.com>"

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

## Open JDK
#RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && apt-get install -y openjdk-8-jdk
## Oracle JDK
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections \
    && add-apt-repository -y ppa:webupd8team/java \
    && DEBIAN_FRONTEND=noninteractive apt-get update -y -qq \
    && apt-get install -y --no-install-recommends \
    oracle-java8-installer \
    oracle-java8-set-default \
    oracle-java8-unlimited-jce-policy \
    && apt-get clean -y && apt-get autoremove -y && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

# Install Git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
    &&DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install git-lfs \
    && git lfs install \
    && apt-get clean -y && apt-get autoremove -y && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

# Go to workspace
RUN mkdir -p /var/workspace
WORKDIR /var/workspace
