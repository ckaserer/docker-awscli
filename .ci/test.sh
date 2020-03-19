#!/bin/bash

source bashrc

set -e
docker-awscli-build --no-cache
docker-awscli sh -c "command -v aws"
echo -e "a\nb\nc\njson\n" | docker run --rm -i gepardec/awscli aws-wrapper configure list
docker tag \
  gepardec/awscli:latest \
  gepardec/awscli:$(\
    docker-awscli aws --version | awk '{print $1}' | sed "s#aws-cli/##g")
set +e