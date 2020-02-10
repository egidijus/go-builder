FROM debian:stretch-backports
ENV TERM=xterm-256color

ENV GOLANG_VERSION 1.13.7
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz

ENV GOWORK /gowork
ENV GOPATH $GOWORK/gohome
ENV GOPACKAGES "$GOPATH/src"

ENV INPUT_REPOS="$GOWORK/input_repos"
ENV OUTPUT_BINARIES="$GOWORK/output_binaries"

ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH:/sbin:/bin:/usr/local/bin/

RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
    g++ \
    gcc \
    bash \
    git \
    sudo \
    wget \
    build-essential \
    curl \
    ca-certificates \
    bash-completion \
    jq \
    libc6-dev \
    make \
    && rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate --quiet "$GOLANG_DOWNLOAD_URL" -O golang.tar.gz \
    && tar -C /usr/local -xzf golang.tar.gz \
    && rm golang.tar.gz

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

VOLUME $GOWORK
WORKDIR $GOWORK
ADD go_builder.sh /usr/local/bin/go_builder
CMD go_builder
