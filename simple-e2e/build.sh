#!/usr/bin/env bash
set -x

arch=""
[ `arch` == i386 ] && arch="-amd64"
[ `arch` == aarch64 ] && arch="-arm64"
[ `arch` == armhf ] && arch="-arm"
[ `arch` == x86_64 ] && arch="-amd64"

# create_and_push_manifest
function create_and_push_manifest {
    ACCOUNT=$1
    D=$2
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

}
# build docker compose with the local yml files
docker build -f docker-compose/Dockerfile -t ${ACCOUNT:-opensourcefoundries}/docker-compose:latest$arch .
docker push ${ACCOUNT:-opensourcefoundries}/docker-compose:latest$arch
create_and_push_manifest ${ACCOUNT:-opensourcefoundries} "docker-compose"

for D in simple*
do
    pushd $D
    echo
    docker build -t ${ACCOUNT:-opensourcefoundries}/$D:latest$arch --force-rm .
    docker push ${ACCOUNT:-opensourcefoundries}/$D:latest$arch

    create_and_push_manifest ${ACCOUNT:-opensourcefoundries} $D

    popd
done
