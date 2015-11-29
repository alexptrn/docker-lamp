#!/bin/bash

if [ -z "$1" ]; then
    echo "Insert image tag";
    exit;
fi

docker build -t $1 $(pwd)
