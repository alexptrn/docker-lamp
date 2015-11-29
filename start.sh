#!/bin/bash

if [ -z "$1" ]; then
    echo "Docker container name not specified";
    exit;
fi

docker start -i $1
