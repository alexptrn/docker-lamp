#!/bin/bash

if [ -z "$1" ]; then
    echo "Docker image name not specified";
    exit;
fi

if [ -z "$2" ]; then
    SHARED_DIR="$(pwd)/sites"
else
    if [ -d "$2" ]; then
        SHARED_DIR="$(pwd)/$2"
    else
        echo "Directory $2 does not exists";
        exit;
    fi
fi

docker run -i -t --name $1 -v ${SHARED_DIR}:/var/www:rw -p 80:80 -p 3306:3306 $1
