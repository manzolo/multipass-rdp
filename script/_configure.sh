#!/bin/bash
. $(dirname $0)/__functions.sh
HOST_DIR_NAME=$1

for file in ${HOST_DIR_NAME}/install/*
do
    [ -f ${file} ] || continue
    msg_warn "install $(basename $file)"
    chmod a+x ${file}
    ${file}
done