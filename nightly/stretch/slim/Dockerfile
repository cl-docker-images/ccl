#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM debian:stretch

ENV CCL_COMMIT 110c23060aa409cb90ffc9eb79a167327f8081d9

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008
RUN set -x \
    && case "$(dpkg --print-architecture)" in \
    armhf) PLATFORM=linuxarm; CCL_SCRIPT=ccl; CCL_RELEASE_VERSION=1.12;; \
    amd64) PLATFORM=linuxx86; CCL_SCRIPT=ccl64; CCL_RELEASE_VERSION=1.12;; \
    *) echo "Unknown arch" >&2; exit 1;; \
    esac \
    && export PLATFORM \
    && export CCL_SCRIPT \
    && export CCL_RELEASE_VERSION \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates build-essential m4 make \
    && curl -fsSL https://github.com/Clozure/ccl/archive/${CCL_COMMIT}.tar.gz > ccl-${CCL_COMMIT}.tar.gz \
    && curl -fsSL https://github.com/Clozure/ccl/releases/download/v${CCL_RELEASE_VERSION}/${PLATFORM}.tar.gz > ${PLATFORM}.tar.gz \
    && gunzip ${PLATFORM}.tar.gz \
    && gunzip ccl-${CCL_COMMIT}.tar.gz \
    && tar xf ccl-${CCL_COMMIT}.tar \
    && mv ccl-${CCL_COMMIT} ccl \
    && ( cd ccl && tar xf ../${PLATFORM}.tar && cp scripts/$CCL_SCRIPT /usr/local/bin/ccl && ccl -b -e "(rebuild-ccl :full t)" ) \
    && rm -rf ccl-${CCL_COMMIT}.tar ${PLATFORM}.tar \
    && apt-get remove -y curl ca-certificates build-essential m4 make \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && ccl --version

WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ccl"]
