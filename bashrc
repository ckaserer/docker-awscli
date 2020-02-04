#!/bin/bash

readonly SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function openshift-create-aws-dir () {
    if [ ! -d "${SCRIPT_DIR}/.aws" ]; then
        echo "# create .aws folder in required location"
        echo "+ mkdir -p ${SCRIPT_DIR}/.aws"
        mkdir -p ${SCRIPT_DIR}/.aws
    fi
}
readonly -f openshift-create-aws-dir
[ "$?" -eq "0" ] || return $?

# docker-aws
function docker-aws () {
  local command="docker run --rm -it -e TZ=Europe/Vienna -v ${SCRIPT_DIR}/.aws:/root/.aws gepardec/aws"
   openshift-create-aws-dir
   echo "+ ${command} $@" && ${command} $@
}
readonly -f docker-aws
[ "$?" -eq "0" ] || return $?
