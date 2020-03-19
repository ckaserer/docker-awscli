#!/bin/bash

readonly DOCKER_AWSCLI_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function __docker-awscli-create-aws-dir () {
  if [ ! -d "$(echo ~/.aws)" ]; then
    echo "# creating .aws folder"
    echo "+ mkdir -p $(echo ~/.aws)"
    mkdir -p $(echo ~)/.aws
  fi
}
readonly -f __docker-awscli-create-aws-dir
[ "$?" -eq "0" ] || return $?

# docker-awscli
function docker-awscli () {
  __docker-awscli-create-aws-dir
  local command="docker run --rm -it -e TZ=Europe/Vienna -v $(echo ~)/.aws:/.aws gepardec/awscli"
  echo "+ ${command} $@" && ${command} $@
}
readonly -f docker-awscli
[ "$?" -eq "0" ] || return $?

# docker-awscli-build
function docker-awscli-build () {
  local command="docker build -t gepardec/awscli $@ ${DOCKER_AWSCLI_HOME}"
  echo "+ ${command}" && ${command}
}
readonly -f docker-awscli-build
[ "$?" -eq "0" ] || return $?