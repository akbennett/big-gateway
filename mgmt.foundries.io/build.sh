#!/usr/bin/env bash

for D in simple*
do
    pushd $D
    docker build -t akbennett/$D --force-rm .
    docker push akbennett/$D
    popd
done
