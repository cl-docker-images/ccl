#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM debian:buster

ENV CCL_VERSION 1.12.1

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008
RUN set -x \
    && case "$(dpkg --print-architecture)" in \
    armhf) PLATFORM=linuxarm; CCL_SCRIPT=ccl;; \
    amd64) PLATFORM=linuxx86; CCL_SCRIPT=ccl64;; \
    *) echo "Unknown arch" >&2; exit 1;; \
    esac \
    && export PLATFORM \
    && export CCL_SCRIPT \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates build-essential m4 make \
    && curl -fsSL https://github.com/Clozure/ccl/archive/v${CCL_VERSION}.tar.gz > v${CCL_VERSION}.tar.gz \
    && curl -fsSL https://github.com/Clozure/ccl/releases/download/v${CCL_VERSION}/${PLATFORM}.tar.gz > ${PLATFORM}.tar.gz \
    && gunzip ${PLATFORM}.tar.gz \
    && gunzip v${CCL_VERSION}.tar.gz \
    && tar xf v${CCL_VERSION}.tar \
    && mv ccl-${CCL_VERSION} ccl \
    && ( cd ccl && tar xf ../${PLATFORM}.tar && cp scripts/$CCL_SCRIPT /usr/local/bin/ccl && ccl -b -e "(rebuild-ccl :full t)" ) \
    && rm -rf v${CCL_VERSION}.tar ${PLATFORM}.tar \
    && apt-get remove -y curl ca-certificates build-essential m4 make \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && ccl --version

WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ccl"]
