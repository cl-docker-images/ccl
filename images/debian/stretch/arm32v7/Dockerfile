FROM debian:stretch

LABEL maintainer="etimmons@mit.edu"

ENV CCL_VERSION=1.12
ARG PLATFORM=linuxarm
ARG CCL_SCRIPT=ccl

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates build-essential m4 make \
    && curl -L https://github.com/Clozure/ccl/archive/v${CCL_VERSION}.tar.gz > v${CCL_VERSION}.tar.gz \
    && curl -L https://github.com/Clozure/ccl/releases/download/v${CCL_VERSION}/${PLATFORM}.tar.gz > ${PLATFORM}.tar.gz \
    && gunzip ${PLATFORM}.tar.gz \
    && gunzip v${CCL_VERSION}.tar.gz \
    && tar xf v${CCL_VERSION}.tar \
    && mv ccl-${CCL_VERSION} ccl \
    && ( cd ccl && tar xf ../${PLATFORM}.tar && cp scripts/$CCL_SCRIPT /usr/local/bin/ccl && ccl -b -e "(rebuild-ccl :full t)" ) \
    && rm -rf v${CCL_VERSION}.tar ${PLATFORM}.tar \
    && apt-get remove -y curl ca-certificates build-essential m4 make \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]

CMD ["ccl"]
