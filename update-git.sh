#!/bin/bash
# Copyright (c) 2020, Aelfa
# All rights reserved.
# Useful script to update already cloned git repos

path() {
    read -r -ep 'ENTER repo location | [EXAMPLE:/opt/scripts/test]: ' repo_path
    if [[ ! -d "${repo_path}/.git" ]]; then
    echo " ⚠️ ${repo_path} is not a git repo location " && path;
    fi
}

update() {
    sudo '$(command -v git)' -C "${repo_path}" pull
    sudo '$(command -v git)' -C "${repo_path}" fetch --all --prune
    sudo '$(command -v git)' -C "${repo_path}" reset --hard HEAD
    sudo '$(command -v git)' -C "${repo_path}" pull
}
permissions() {
    sudo '$(command -v chown)' -cR 1000:1000 "${repo_path}" 1>/dev/null 2>&1
    sudo '$(command -v chmod)' -cR 755 "${repo_path}" 1>/dev/null 2>&1
}
path
permissions
update