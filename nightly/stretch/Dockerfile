#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM buildpack-deps:stretch

ENV CCL_COMMIT 27c4bc11b1839ed0799d4666f76fa94088d5893e

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
    && curl -fsSL https://github.com/Clozure/ccl/archive/${CCL_COMMIT}.tar.gz > ccl-${CCL_COMMIT}.tar.gz \
    && curl -fsSL https://github.com/Clozure/ccl/releases/download/v${CCL_RELEASE_VERSION}/${PLATFORM}.tar.gz > ${PLATFORM}.tar.gz \
    && gunzip ${PLATFORM}.tar.gz \
    && gunzip ccl-${CCL_COMMIT}.tar.gz \
    && tar xf ccl-${CCL_COMMIT}.tar \
    && mv ccl-${CCL_COMMIT} ccl \
    && ( cd ccl && tar xf ../${PLATFORM}.tar && cp scripts/$CCL_SCRIPT /usr/local/bin/ccl && ccl -b -e "(rebuild-ccl :full t)" ) \
    && rm -rf ccl-${CCL_COMMIT}.tar ${PLATFORM}.tar \
    && ccl --version

# Add the Quicklisp installer.
WORKDIR /usr/local/share/common-lisp/source/quicklisp/

ENV QUICKLISP_SIGNING_KEY D7A3489DDEFE32B7D0E7CC61307965AB028B5FF7

RUN set -x \
    && curl -fsSL "https://beta.quicklisp.org/quicklisp.lisp" > quicklisp.lisp \
    && curl -fsSL "https://beta.quicklisp.org/quicklisp.lisp.asc" > quicklisp.lisp.asc \
    && GNUPGHOME="$(mktemp -d)" \
    && export GNUPGHOME \
    && gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "${QUICKLISP_SIGNING_KEY}" \
    && gpg --batch --verify "quicklisp.lisp.asc" "quicklisp.lisp" \
    && rm quicklisp.lisp.asc \
    && rm -rf "$GNUPGHOME"

# Add the script to trivially install Quicklisp
COPY install-quicklisp /usr/local/bin/install-quicklisp

# Add the entrypoint
WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ccl"]
