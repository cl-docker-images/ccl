FROM ubuntu:focal

LABEL maintainer="etimmons@mit.edu"

ARG ref=master
ENV CCL_REF=$ref
ARG PLATFORM=linuxx86
ARG CCL_SCRIPT=ccl64

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008
RUN set -x \
    && CCL_VERSION=1.12 \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates build-essential m4 make git \
    && git clone https://github.com/Clozure/ccl.git ccl-dev \
    && (cd ccl-dev && git archive --prefix=ccl/ "$CCL_REF" | tar -C .. -x ) \
    && curl -L https://github.com/Clozure/ccl/releases/download/v${CCL_VERSION}/${PLATFORM}.tar.gz > ${PLATFORM}.tar.gz \
    && gunzip ${PLATFORM}.tar.gz \
    && ( cd ccl && tar xf ../${PLATFORM}.tar && cp scripts/$CCL_SCRIPT /usr/local/bin/ccl && ccl -b -e "(rebuild-ccl :full t)" ) \
    && rm -rf ccl-dev ${PLATFORM}.tar \
    && apt-get remove -y curl ca-certificates build-essential m4 make git \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]

CMD ["ccl"]
