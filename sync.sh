#!/bin/bash

# Sync /etc/nixos with your git repo
rsync -av --delete /etc/nixos/ ./nixos/

# Sync ~/.config with your git repo

rsync -av --delete ~/.config/{helix,kitty,hypr} ./config/

# Add changes and commit
git add .
git commit -m "Sync latest config"
git push
