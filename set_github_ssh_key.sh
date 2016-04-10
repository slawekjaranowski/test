#!/bin/bash

set -e

if [ -z "$GITHUB_SSH_KEY" ]; then
    GITHUB_SSH_KEY="ssh-key.enc"
fi

if [ -z "$GITHUB_SSH_KEY_PASS" ]; then
    echo "environment GITHUB_SSK_KEY_PASS is not set"
    exit 1
fi

if [ ! -f $GITHUB_SSH_KEY ]; then
    echo "SSH key: $GITHUB_SSH_KEY not exist"
    exit 2
fi

if [ ! -d $HOME/.ssh ]; then
    mkdir -p $HOME/.ssh
    chmod 700  $HOME/.ssh
fi

MY_SSH_KEY="$HOME/.ssh/"`basename ${GITHUB_SSH_KEY%.*}`

openssl aes-256-cbc -in $GITHUB_SSH_KEY -out $MY_SSH_KEY -k "$GITHUB_SSH_KEY_PASS" -d
chmod 600 $MY_SSH_KEY

touch $HOME/.ssh/config

cat << EOF >> $HOME/.ssh/config

host github.com
    HostName github.com
    IdentityFile $MY_SSH_KEY
    User git
EOF
