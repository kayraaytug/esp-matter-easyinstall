#!/bin/bash

# Install dependencies for ESP-IDF
sudo apt-get update
sudo apt-get install -y git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0

# Clone ESP-IDF repository
mkdir -p ~/esp
cd ~/esp
git clone --recursive https://github.com/espressif/esp-idf.git
cd ~/esp/esp-idf
./install.sh esp32
source $HOME/esp/esp-idf/export.sh

# Install dependencies for ESP-Matter
sudo apt-get install -y git gcc g++ pkg-config libssl-dev libdbus-1-dev \
     libglib2.0-dev libavahi-client-dev ninja-build python3-venv python3-dev \
     python3-pip unzip libgirepository1.0-dev libcairo2-dev libreadline-dev
sudo apt-get install -y libsdl2-dev

# Clone ESP-Matter repository
cd ~/esp
git clone --depth 1 https://github.com/espressif/esp-matter.git
cd esp-matter
git submodule update --init --depth 1
cd ./connectedhomeip/connectedhomeip
./scripts/checkout_submodules.py --platform esp32 linux --shallow
cd ../../..

# Run ESP-Matter installation script
./esp-matter/install.sh

# Set IDF_CCACHE_ENABLE environment variable
export IDF_CCACHE_ENABLE=1

# Define espshell alias
echo 'alias espshell="cd $HOME/esp/esp-idf && source ./export.sh && cd $HOME/esp/esp-matter && source ./export.sh"' >> ~/.bashrc

echo 'To initialize esp-matter environment execute "espshell". This needs to be done for each new terminal session.'

echo "Installation completed."
