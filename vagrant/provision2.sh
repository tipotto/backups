## Create requirements.txt
echo "### Create requirements.txt ###"
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
echo "### Install Python packages ###"
pip install -r $PYTHON_PKG_FILE_PATH

### Install Google Chrome
echo "### Install Google Chrome ###"
CHROME_VERSION='99.0.4844.51'
wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}-1_amd64.deb -O /tmp/chrome.deb --no-verbose \
		&& apt install -y /tmp/chrome.deb \
					 && rm /tmp/chrome.deb

echo "### Chrome: $(google-chrome --version) ###"

### Install Chrome Driver
echo "### Install Chrome Driver ###"
wget https://chromedriver.storage.googleapis.com/${CHROME_VERSION}/chromedriver_linux64.zip -O /tmp/chromedriver.zip \
		&& apt install -y unzip \
		&& unzip /tmp/chromedriver.zip -d /tmp \
						 && mv /tmp/chromedriver /bin/chromedriver

echo "### ChromeDriver: $(chromedriver --version) ###"
