#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

declare -A refs=(
    [1.12.2-rc]='master'
)

versions=( "$@" )

generated_warning() {
    cat <<EOH
#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
EOH
}

for version in "${versions[@]}"; do

    if [[ $version == *rc ]]; then
        cclGitSha="$(curl -fsSL https://api.github.com/repos/Clozure/ccl/commits/"${refs[$version]}" | jq -r .sha)"
        unset cclSourceUrl
        unset cclSourceSha
    else
        unset cclGitSha
        cclSourceUrl="https://github.com/Clozure/ccl/releases/download/v$version/ccl-$version-windowsx86.zip"
        cclSourceSha="$(curl -fsSL "$cclSourceUrl" | sha256sum | cut -d' ' -f1)"
    fi

    for v in \
        bullseye/{,slim} \
        buster/{,slim} \
        windowsservercore-{ltsc2019,1809}/ \
    ; do
        os="${v%%/*}"
        variant="${v#*/}"
        dir="$version/$v"

        if [[ $version == *rc ]] && [[ "$os" == "windowsservercore"* ]]; then
            continue
        fi

        mkdir -p "$dir"

        case "$os" in
            bullseye|buster|stretch)
                template="apt"
                if [ "$variant" = "slim" ]; then
                    from="debian:$os"
                else
                    from="buildpack-deps:$os"
                    cp install-quicklisp "$dir/install-quicklisp"
                fi
                cp docker-entrypoint.sh "$dir/docker-entrypoint.sh"
                ;;
            alpine*)
                template="apk"
                cp docker-entrypoint.sh "$dir/docker-entrypoint.sh"
                from="alpine:${os#alpine}"
                ;;
            windowsservercore-*)
                template='windowsservercore'
                from="mcr.microsoft.com/windows/servercore:${os#*-}"
                ;;
        esac

        if [ -n "$variant" ]; then
            template="$template-$variant"
        fi

        if [[ $version == *rc ]]; then
            template="$template-nightly"
        fi

        template="Dockerfile-${template}.template"

        { generated_warning; cat "$template"; } > "$dir/Dockerfile"

        if [[ $version == *rc ]]; then
            sed -ri \
                -e 's,^(FROM) .*,\1 '"$from"',' \
                -e 's/^(ENV CCL_COMMIT) .*/\1 '"$cclGitSha"'/' \
                "$dir/Dockerfile"
        else
            sed -ri \
                -e 's/^(ENV CCL_VERSION) .*/\1 '"$version"'/' \
                -e 's/^(ENV CCL_SOURCE_SHA256) .*/\1 '"$cclSourceSha"'/' \
                -e 's,^(FROM) .*,\1 '"$from"',' \
                "$dir/Dockerfile"
        fi
    done
done
