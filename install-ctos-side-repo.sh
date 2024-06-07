#!/bin/bash

clear
workDIR=$PWD
echo $workDIR
echo "Adding keys to pacman ..."
sudo pacman -Syu wget
cd $workDIR
mkdir -p .temp
cd .temp
wget https://coopertronic-ws.ddns.net/ctos-assets/ctos-keys/ctos-trusted
wget https://coopertronic-ws.ddns.net/ctos-assets/ctos-keys/ctos.gpg
addRepoToConfig=$(
    cat <<"EOT"

[ctos-side-repo]
SigLevel = Optional DatabaseOptional
Server = https://coopertronic-ws.ddns.net/$repo/$arch

EOT
)
getPacmanConf=$(cat /etc/pacman.conf)
echo "$getPacmanConf$addRepoToConfig" >>pacman.conf
ls -a
sudo cp -vir "$workDIR/.temp/ctos.gpg" /usr/share/pacman/keyrings/
sudo cp -vir "$workDIR/.temp/ctos-trusted" /usr/share/pacman/keyrings/
#sudo cp -vir "$workDIR/.temp/pacman.conf" /etc/
cd ../
rm -r .temp
ls -a /usr/share/pacman/keyrings/
#sudo pacman-key --init
#sudo pacman-key --populate archlinux ctos
#sudo pacman -Syyu ctos-functions --noconfirm

echo $workDIR

