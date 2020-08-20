FROM ubuntu:20.04

USER root

RUN apt update && \
    apt install --no-install-recommends -y -y python3.8-dev \
    python3-pip \
    curl \
    gcc \
    python3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update && \
    apt install --no-install-recommends -y nodejs \
    yarn && \
    apt remove -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install hyperglass

RUN mkdir -p /etc/hyperglass/static/ui && \
    mkdir -p /etc/hyperglass/static/images && \
    mkdir -p /etc/hyperglass/static/custom && \
    mkdir -p /etc/hyperglass/static/images/favicons && \
    cp /usr/local/lib/python3.8/dist-packages/hyperglass/images/* /etc/hyperglass/static/images && \
    cp /usr/local/lib/python3.8/dist-packages/hyperglass/examples/* /etc/hyperglass/ && \
    chown -R root:root /etc/hyperglass

EXPOSE 8001

ENTRYPOINT ["hyperglass","start"]
