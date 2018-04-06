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

# create a manifest for atleast 1 image
docker manifest create --amend \
    ${ACCOUNT:-opensourcefoundries}/$D:latest \
        ${ACCOUNT:-opensourcefoundries}/$D:latest$arch

# create a manifest for atleast 2 images
docker manifest create --amend \
    ${ACCOUNT:-opensourcefoundries}/$D:latest \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-arm64 \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-amd64
docker manifest create --amend \
    ${ACCOUNT:-opensourcefoundries}/$D:latest \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-arm64 \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-arm
docker manifest create --amend \
    ${ACCOUNT:-opensourcefoundries}/$D:latest \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-arm64 \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-amd64

# create a manifest for atleast 2 images
docker manifest create --amend \
    ${ACCOUNT:-opensourcefoundries}/$D:latest \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-arm64 \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-amd64 \
        ${ACCOUNT:-opensourcefoundries}/$D:latest-arm

# push the manifest that won the battle
docker manifest push ${ACCOUNT:-opensourcefoundries}/$D:latest

echo "Build Completed, multiarch images found for: "
docker manifest inspect ${ACCOUNT:-opensourcefoundries}/$D:latest | grep architecture

#Once you build a docker file for each architecture, you can add a manifest
#manifest-tool-darwin-amd64 \
#        --username $USER --password $PASSWORD push from-args \
#        --platforms linux/amd64,linux/arm64 \
#        --template ${ACCOUNT:-opensourcefoundries}/$D:latest-ARCH \
#        --target ${ACCOUNT:-opensourcefoundries}/$D:latest
