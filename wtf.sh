#!/bin/bash

set -o errexit

dira=$(mktemp -d /tmp/foo.XXXXXX)
dirb=$(mktemp -d /tmp/foo.XXXXXX)

function cleanup_and_die {
    [ -z ${dira} ] || rm -rf ${dira}
    [ -z ${dirb} ] || rm -rf ${dirb}
    exit
}

trap cleanup_and_die SIGINT
trap cleanup_and_die SIGTERM
trap cleanup_and_die EXIT

if [ $(uname -s) == "Darwin" ]; then
    ext="dylib"
    export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${dirb}
else
    export LD_LIBRAY_PATH=${LD_LIBRARY_PATH}:${dirb}
    ext="so"
fi

cp libfoo.${ext} ${dira}
cp libfakefoo.${ext} ${dirb}/libfoo.${ext}

echo "Doing dlopen on the real libfoo. Any sane system will report so:"
./main ${dira}/libfoo.${ext}
