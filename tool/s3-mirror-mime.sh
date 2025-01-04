#!/usr/bin/env bash

set -x

src=$1
dst=$2

# function mimeOf {
#   filename=$1
#   ext=${filename##*.}
#   case "${ext}" in
#     crt) echo 'application/x-pem-file' ;;
#     css) echo 'text/css' ;;
#     html|htm) echo 'text/html' ;;
#     js) echo 'text/javascript' ;;
#     json) echo 'application/json' ;;
#     pdf) echo 'application/pdf' ;;
#     xml) echo 'text/xml' ;;
#     *) echo 'application/octet-stream' ;;
#   esac
# }

# Sync
mc mirror $src $dst --overwrite --remove

# # Fix mimetypes
# mc ls --recursive "${dst}" | awk '{print $NF}' | while read obj; do
#   mime=$(mimeOf "${obj}")
#   mc cp "${dst}/${obj}" --attr="content-type=${mime}" "${dst}/${obj}"
# done
