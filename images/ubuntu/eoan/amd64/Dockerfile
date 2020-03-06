FROM ubuntu:eoan

LABEL maintainer="etimmons@mit.edu"

ENV CCL_VERSION=1.11.5

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && wget https://github.com/Clozure/ccl/releases/download/v${CCL_VERSION}/ccl-${CCL_VERSION}-linuxx86.tar.gz \
    && gunzip ccl-${CCL_VERSION}-linuxx86.tar.gz \
    && tar xf ccl-${CCL_VERSION}-linuxx86.tar \
    && (cd ccl && rm -rf .git && cp scripts/ccl64 /usr/local/bin/ccl ) \
    && rm ccl-${CCL_VERSION}-linuxx86.tar \
    && apt-get remove -y wget ca-certificates \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

ENTRYPOINT ["ccl"]
