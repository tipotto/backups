#!/bin/bash

#red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}##### User: $(whoami) #####${reset}"
echo "${green}##### Home directory: $HOME #####${reset}"

#export DEBIAN_FRONTEND=noninteractive

## Update apt package list and upgrade installed packages
echo "${green}##### Update apt package list and upgrade installed packages #####${reset}"
sudo apt update -y && sudo apt upgrade -y

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
#[ -z "$(sudo swapon --show)" ] && echo "test"

## Update sshd_config
echo "${green}##### Update sshd_config #####${reset}"
sed -i.bak -e 's/#Port 22/Port 49152/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

## Update Crontab
echo "${green}##### Update Crontab #####${reset}"
sed -i.bak -e 's/SHELL=\/bin\/sh/SHELL=\/bin\/bash/g' /etc/crontab
echo '0 0 */2 * * root /root/.pyenv/shims/python /var/www/api/app/python/refresh_token.py >> /var/log/cron.log 2>&1' >> /etc/crontab

### Install Google Cloud SDK
#echo "${green}##### Install Google Cloud SDK #####${reset}"
#### Add URI to package source list
#echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#
#### Install packages needed
#sudo apt install -y apt-transport-https ca-certificates gnupg
#
#### Import Google Cloud public key
#curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
#
#### Update and Install Google Cloud SDK
#sudo apt update -y && sudo apt install -y google-cloud-sdk

## Install latest Nginx
echo "${green}##### Install latest Nginx #####${reset}"
NGINX_CONF=/etc/nginx/sites-available/default
sudo apt install -y nginx && cp $NGINX_CONF ${NGINX_CONF}.bak
echo "${green}##### Nginx: $(nginx -v) #####${reset}"

## Install Let's Encrypt
echo "${green}##### Install Let's Encrypt #####${reset}"
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d www.markets-jp.com -m tipotto404@gmail.com --agree-tos -n

cat > $NGINX_CONF <<- EOM
server {
    if (\$host = www.markets-jp.com) {
        return 301 https://\$host\$request_uri;
    }

    # Drop the request if it does not include Host header.
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;

    return 444;
}

server {
    listen 80;
    listen [::]:80;

    server_name www.markets-jp.com;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}

server {
    listen [::]:443 ssl ipv6only=on;
    listen 443 ssl;

    server_name www.markets-jp.com;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    ssl_certificate /etc/letsencrypt/live/www.markets-jp.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/www.markets-jp.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location ~ ^/(search|analyze)$ {
        try_files \$uri \$uri/ =404;
    }

    location ~ ^/api/v1/(search|analyze)$ {
        proxy_pass http://127.0.0.1:8080;
        proxy_pass_request_headers on;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOM

echo "${green}##### Restart nginx #####${reset}"
sudo systemctl restart nginx

## Install Node.js and npm
echo "${green}##### Install NVM #####${reset}"
### Download the install script from Github and excute it
cd ~ && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

### The following needs to be added
### .bashrc doesn't do anything when not executed interactively
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.bashrc
#echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> $HOME/.bashrc
#echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.bashrc
echo "${green}##### NVM: $(nvm -v) #####${reset}"

### Install latest Node.js LTS and npm
#nvm install --lts --latest-npm
echo "${green}####### Install Node #####${reset}"
nvm install v14.17.0
echo "${green}##### Node: $(node -v) #####${reset}"

### Install Yarn globally
echo "${green}##### Install Yarn #####${reset}"
npm install -g yarn
echo 'export PATH="$PATH:$(yarn global bin)"  # Load global yarn binaries' >> $HOME/.bashrc
echo "${green}##### Yarn: $(yarn -v) #####${reset}"

echo "${green}##### Install forever #####${reset}"
yarn global add forever
echo "${green}##### forever: $(forever --version) #####${reset}"

## Install pypy
### Install dependencies
echo "${green}##### Install Pyenv #####${reset}"
sudo apt install -y \
		 build-essential \
		 libffi-dev \
		 libssl-dev \
		 zlib1g-dev \
		 liblzma-dev \
		 libbz2-dev \
		 libreadline-dev \
		 libsqlite3-dev \
		 libopencv-dev \
		 tk-dev \
		 git

### Install pyenv in home directory
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

### Optional: Checkout pyenv v.2.0.4 
cd ~/.pyenv && git checkout v2.0.4

### Update .bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc
echo 'eval "$(pyenv init --path)"' >> $HOME/.bashrc

### The following needs to be added
### .bashrc doesn't do anything when not executed interactively
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

echo "${green}##### Pyenv: $(pyenv -v) #####${reset}"

### Install pypy
echo "${green}##### Install Pypy #####${reset}"
#PYPY_VERSION=$(pyenv install -l | grep -E "pypy3\.[0-9]{1,2}" | grep -vE "alpha|beta|src" | tail -1 | xargs)
PYPY_VERSION='pypy3.7-7.3.5'
if [ -n "$PYPY_VERSION" ]; then
		pyenv install "$PYPY_VERSION"
		pyenv global "$PYPY_VERSION"
fi

echo "${green}##### Pyenv py: $(pyenv version) #####${reset}"
echo "${green}##### Python: $(python -V) #####${reset}"
echo "${green}##### Py location: $(which python) #####${reset}"

## Upgrade pip
echo "${green}##### Upgrade pip #####${reset}"
python -m pip install --upgrade pip

## Create requirements.txt
echo "${green}##### Create requirements.txt #####${reset}"
PYTHON_PKG_FILE_PATH="${HOME}/requirements.txt"
cat > $PYTHON_PKG_FILE_PATH <<- EOM
aiodns==3.0.0
aiohttp==3.8.1
aiosignal==1.2.0
appdirs==1.4.4
async-timeout==4.0.2
asynctest==0.13.0
attrs==21.2.0
beautifulsoup4==4.9.3
blinker==1.4
Brotli==1.0.9
brotlipy==0.7.0
bs4==0.0.1
cachetools==5.0.0
cchardet==2.1.7
certifi==2021.10.8
cffi==1.14.5
chardet==4.0.0
charset-normalizer==2.0.12
cryptography==36.0.1
cssselect==1.1.0
fake-headers==1.0.2
fake-useragent==0.1.11
frozenlist==1.3.0
google-auth==2.6.3
greenlet==0.4.13
h11==0.13.0
h2==4.1.0
hpack==4.0.0
html5lib==1.1
hyperframe==6.0.1
idna==3.2
importlib-metadata==4.11.1
kaitaistruct==0.9
lxml==4.8.0
multidict==5.1.0
numpy==1.21.0
parse==1.19.0
pyasn1==0.4.8
pyasn1-modules==0.2.8
pycares==4.0.0
pyee==8.2.2
pyOpenSSL==22.0.0
pyparsing==3.0.7
pyppeteer==1.0.2
pyquery==1.4.3
PySocks==1.7.1
readline==6.2.4.1
requests==2.27.1
requests-html==0.10.0
rsa==4.8
selenium==3.141.0
selenium-wire==4.6.3
six==1.16.0
soupsieve==2.2.1
tqdm==4.62.3
typing-extensions==3.10.0.0
urllib3==1.26.8
uvloop==0.16.0
w3lib==1.22.0
webencodings==0.5.1
websockets==10.1
wsproto==1.1.0
yarl==1.6.3
zipp==3.7.0
zstandard==0.17.0
EOM

## Install Python packages
echo "${green}##### Install Python packages #####${reset}"
pip install -r $PYTHON_PKG_FILE_PATH

## Selenium
### Install Google Chrome
echo "${green}##### Install Google Chrome #####${reset}"
CHROME_VERSION='99.0.4844.51'
wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}-1_amd64.deb -O /tmp/chrome.deb --no-verbose \
		&& apt install -y /tmp/chrome.deb \
					 && rm /tmp/chrome.deb
echo "${green}##### Google Chrome: $(google-chrome --version) #####${reset}"

### Install Chrome Driver
echo "${green}##### Install Chrome Driver #####${reset}"
wget https://chromedriver.storage.googleapis.com/${CHROME_VERSION}/chromedriver_linux64.zip -O /tmp/chromedriver.zip \
		&& apt install -y unzip \
		&& unzip /tmp/chromedriver.zip -d /tmp \
		&& mv /tmp/chromedriver /bin/chromedriver \
					&& rm /tmp/chromedriver.zip
echo "${green}##### ChromeDriver: $(chromedriver --version) #####${reset}"
