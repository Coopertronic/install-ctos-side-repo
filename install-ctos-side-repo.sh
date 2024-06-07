#!/bin/bash

clear
echo "Adding keys to pacman ..."
sudo pacman -Syu wget
sudo wget https://coopertronic-ws.ddns.net/ctos-assets/ctos-keys/ctos-trusted -P /usr/share/pacman/keyrings/ -O ctos-trusted
sudo wget https://coopertronic-ws.ddns.net/ctos-assets/ctos-keys/ctos.gpg -P /usr/share/pacman/keyrings/ -O ctos.gpg
addRepoToConfig=$(
    cat <<"EOT"

[ctos-side-repo]
SigLevel = Optional DatabaseOptional
Server = https://coopertronic-ws.ddns.net/$repo/$arch

EOT
)
sudo echo $addRepoToConfig >> "/etc/pacman.conf"
sudo pacman-key --init
sudo pacman-key --populate archlinux ctos
sudo pacman -Syyu ctos-functions --noconfirm
