#!/usr/bin/env bash
set -x

arch="bogus"
[ `arch` == i386 ] && arch="-amd64"
[ `arch` == aarch64 ] && arch="-arm64"
[ `arch` == armhf ] && arch="-arm"
[ `arch` == x86_64 ] && arch="-amd64"

# create_and_push_manifest
# this function attempts to brute-force push the manifest
function create_and_push_manifest {
    ACCOUNT=$1
    D=$2
    # create a manifest for atleast 1 image
    docker manifest create --amend \
        ${ACCOUNT:-opensourcefoundries}/$D:latest \
            ${ACCOUNT:-opensourcefoundries}/$D:latest$arch

    # create a manifest for atlearst 2 images
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
            ${ACCOUNT:-opensourcefoundries}/$D:latest-arm \
            ${ACCOUNT:-opensourcefoundries}/$D:latest-amd64

    # create a manifest for atleast 2 images
    docker manifest create --amend \
        ${ACCOUNT:-opensourcefoundries}/$D:latest \
            ${ACCOUNT:-opensourcefoundries}/$D:latest-arm64 \
            ${ACCOUNT:-opensourcefoundries}/$D:latest-amd64 \
            ${ACCOUNT:-opensourcefoundries}/$D:latest-arm

    # push the manifest that won the battle
    docker manifest push --purge ${ACCOUNT:-opensourcefoundries}/$D:latest

}

for D in simple*
do
    pushd $D

    docker build -t ${ACCOUNT:-opensourcefoundries}/$D:latest$arch --force-rm .
    docker push ${ACCOUNT:-opensourcefoundries}/$D:latest$arch

    create_and_push_manifest ${ACCOUNT:-opensourcefoundries} $D

    popd
done
