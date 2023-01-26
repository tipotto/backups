#!/bin/bash

echo "User: $(whoami)"
echo "Home directory: $(printenv HOME)"

#export DEBIAN_FRONTEND=noninteractive

## Install Google Cloud SDK
### Add URI to package source list
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

### Install packages needed
sudo apt install -y apt-transport-https ca-certificates gnupg

### Import Google Cloud public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

### Update and Install Google Cloud SDK
sudo apt update && sudo apt install -y google-cloud-sdk

gcloud auth activate-service-account \
		 multitor@markets-jp.iam.gserviceaccount.com \
		 --key-file /tmp/multitor.json \
		 --project markets-jp

## Install multitor
git clone https://github.com/trimstray/multitor.git /root/multitor

MULTITOR_GCS_BUCKET='multitor-config'
MULTITOR_DIR_PATH="gs://${MULTITOR_GCS_BUCKET}/multitor-settings"
MULTITOR_SETTING_FILES=$(gsutil ls "gs://${MULTITOR_DIR_PATH}" || "")

echo "MULTITOR_SETTING_FILES: $MULTITOR_SETTING_FILES"

if [ -n "$MULTITOR_SETTING_FILES" ]; then
    MULTITOR_TEMP_DIR_PATH='/root/multitor/templates'
    MULTITOR_BACKUP_DIR_PATH="${MULTITOR_TEMP_DIR_PATH}/backups"
    mkdir $MULTITOR_BACKUP_DIR_PATH
    mv ${MULTITOR_TEMP_DIR_PATH}/*.cfg $MULTITOR_BACKUP_DIR_PATH
    gsutil -q -m cp -r ${MULTITOR_DIR_PATH}/*.cfg "$MULTITOR_TEMP_DIR_PATH"
fi

## markets setup
sudo mkdir /root/markets && cd /root/markets

### frontend
git clone https://github.com/tipotto/markets-frontend.git /root/markets/frontend

### backend
git clone https://github.com/tipotto/markets-backend.git /root/markets/backend

# TODO: Error occurs when executing yarn. Needs to install it.
#cd /root/markets/frontend && yarn install
#cd /root/markets/backend && yarn install


## Update apt package list and upgrade installed packages
#sudo apt update && sudo apt upgrade -y
#
## Swap settings
#if [ -z "$(sudo swapon --show)" ]; then
#		## Activate swapfile
#		sudo fallocate -l 2G /swapfile
#    sudo chmod 600 /swapfile
#		sudo mkswap /swapfile >/dev/null
#		sudo swapon /swapfile
#
#		## Persist swapfile
#		sudo cp /etc/fstab /etc/fstab.bak
#		echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab >/dev/null
#
#		## Set up swappiness
#		sudo sysctl vm.swappiness=10 >/dev/null
#		echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf >/dev/null
#
#		## Set up cache pressure
#		sudo sysctl vm.vfs_cache_pressure=50 >/dev/null
#		echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf >/dev/null
#fi
##[ -z "$(sudo swapon --show)" ] && echo "test"
#
## Install Node.js and npm
### Download the install script from Github and excute it
#cd ~ && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
#
### The following needs to be added
### .bashrc doesn't do anything when not executed interactively
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
### Install latest Node.js LTS and npm
#nvm install --lts --latest-npm
#
## Install pypy
### Install dependencies
#sudo apt install -y \
#		 build-essential \
#		 libffi-dev \
#		 libssl-dev \
#		 zlib1g-dev \
#		 liblzma-dev \
#		 libbz2-dev \
#		 libreadline-dev \
#		 libsqlite3-dev \
#		 libopencv-dev \
#		 tk-dev \
#		 git
#
### Install pyenv in home directory
#git clone https://github.com/pyenv/pyenv.git ~/.pyenv
#
### Optional: Checkout pyenv v.2.0.4 
#cd ~/.pyenv && git checkout v2.0.4
#
### Update .bashrc
#echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
#echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
#echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
#
### The following needs to be added
### .bashrc doesn't do anything when not executed interactively
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"
#
### Install pypy
#PYPY_VERSION=$(pyenv install -l | grep -E "pypy3\.[0-9]{1,2}" | grep -vE "alpha|beta|src" | tail -1 | xargs)
#echo "PYPY_VERSION:$PYPY_VERSION"
#
#if [ -n "$PYPY_VERSION" ]; then
#		pyenv install "$PYPY_VERSION"
#		pyenv global "$PYPY_VERSION"
#fi
#
### Upgrade pip
#python -m pip install --upgrade pip
#
### Install dependencies
#pip install \
#		beautifulsoup4 \
#		aiohttp[speedups] \
#		fake_headers \
#		numpy
#

