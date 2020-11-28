#!/bin/sh

set -e

grep -e "^ENV CCL_COMMIT" nightly/buster/Dockerfile | cut -d" " -f 3
