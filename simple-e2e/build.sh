#!/usr/bin/env bash
set -x

arch=""
[ `arch` == i386 ] && arch="-amd64"
[ `arch` == aarch64 ] && arch="-arm64"
[ `arch` == armhf ] && arch="-arm"
[ `arch` == x86_64 ] && arch="-amd64"

for D in simple*
do
    pushd $D
    echo
    docker build -t ${ACCOUNT:-opensourcefoundries}/$D:latest$arch --force-rm .
    docker push ${ACCOUNT:-opensourcefoundries}/$D:latest$arch
    popd
done

#Once you build a docker file for each architecture, you can add a manifest
#manifest-tool-darwin-amd64 \
#        --username $USER --password $PASSWORD push from-args \
#        --platforms linux/amd64,linux/arm64 \
#        --template ${ACCOUNT:-opensourcefoundries}/$D:latest-ARCH \
#        --target ${ACCOUNT:-opensourcefoundries}/$D:latest
