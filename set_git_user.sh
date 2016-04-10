#!/bin/bash

set -e

git config --local user.name  "`git log -1 --format="%an"`"
git config --local user.email "`git log -1 --format="%ae"`"

echo "Git user settings"
git config --local --get-regexp user.*
