#!/bin/bash

readonly SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function openshift-create-aws-dir () {
    if [ ! -d "~/.aws" ]; then
        echo "# create .aws folder"
        echo "+ mkdir -p ~/.aws"
        mkdir -p ~/.aws
    fi
}
readonly -f openshift-create-aws-dir
[ "$?" -eq "0" ] || return $?

# docker-aws
function docker-aws () {
  local command="docker run --rm -it -e TZ=Europe/Vienna -v ~/.aws:/root/.aws gepardec/aws"
   openshift-create-aws-dir
   echo "+ ${command} $@" && ${command} $@
}
readonly -f docker-aws
[ "$?" -eq "0" ] || return $?
