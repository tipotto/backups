#!/bin/bash

#red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}##### Update sshd_config #####${reset}"
cat /etc/ssh/sshd_config

echo "${green}##### Update Crontab #####${reset}"
cat /etc/crontab

echo "${green}##### Install latest Nginx #####${reset}"
echo "Nginx: $(nginx -v)"
cat /etc/nginx/sites-available/default

echo "${green}##### Install NVM #####${reset}"
echo "NVM: $(nvm --version)"

echo "${green}##### Install Node #####${reset}"
echo "Node: $(node -v)"

echo "${green}##### Install Yarn #####${reset}"
echo "Yarn: $(yarn -v)"

echo "${green}##### Install Pyenv #####${reset}"
echo "Pyenv: $(pyenv -v)"

echo "${green}##### Install Pypy #####${reset}"
echo "Pyenv py: $(pyenv version)"
echo "Python: $(python -V)"
echo "Py location: $(which python)"

echo "${green}##### Upgrade pip #####${reset}"
echo "pip: $(pip -V)"

echo "${green}##### Create requirements.txt #####${reset}"
cat ~/requirements.txt

echo "${green}##### Install Google Chrome #####${reset}"
echo "Google Chrome: $(google-chrome --version)"

echo "${green}##### Install Chrome Driver #####${reset}"
echo "ChromeDriver: $(chromedriver --version)"
