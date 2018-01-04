#!/bin/bash

if [ ! -z "${SMB_USER}" ]; then
    if [ ! -z "${SMB_UID}" ]; then
        cmd="$cmd --uid ${SMB_UID}"
    fi
    if [ ! -z "${SMB_GID}" ]; then
        cmd="$cmd --gid ${SMB_GID}"
        groupadd --gid ${SMB_GID} ${SMB_USER}
    fi
    adduser $cmd --no-create-home --disabled-password --gecos '' "${SMB_USER}"
    if [ ! -z "${SMB_PASSWORD}" ]; then
        echo "${SMB_USER}:${SMB_PASSWORD}" | chpasswd
        (echo ${SMB_PASSWORD}; echo ${SMB_PASSWORD}) | /usr/local/samba/bin/smbpasswd -s -a ${SMB_USER}
    fi
fi

exec /init
