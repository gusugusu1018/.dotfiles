#!/bin/bash

readonly OS="ubuntu1404"
readonly VERSION="8.0.81-1_amd64"

sudo stop lightdm
cd $HOME/Downloads
wget http://developer.download.nvidia.com/compute/cuda/repos/${OS}/x86_64/cuda-repo-${OS}_${VERSION}.deb
sudo dpkg -i cuda-repo-ubuntu1404_8.0.61-1_amd64.deb
sudo apt update
sudo apt install cuda
