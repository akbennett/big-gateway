#!/usr/bin/env bash
set -x
for D in simple*
do
    pushd $D
    echo
    docker build -t ${ACCOUNT:-opensourcefoundries}/$D .
    #docker push $topdir/$D
    popd
done
