#!/bin/bash

# TODO check if local branch is behind

rsync -av --delete /etc/nixos/ ./nixos/

rsync -av --delete ~/.config/{helix,kitty,hypr} ./config/

git add .
git commit -m "Sync latest config"
git push
