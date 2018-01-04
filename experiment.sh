#!/usr/bin/env bash
clear
echo "Starting Hacktiv8 Workstation"
echo "https://github.com/hacktiv8/setup/"
echo
echo "Enter admin password"

# Fail immediately if any errors occur
# set -e

# Ask for sudo upfront
sudo -K 
sudo true;

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install all available updates
sudo softwareupdate -iva

# Install Xcode command line tools
xcode-select --install
MY_DIR="$(dirname "$0")"

# Install Brew
if hash brew 2>/dev/null; then
  echo "Homebrew is already installed!"
else
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo
echo "Ensuring you have the latest Homebrew..."
brew update

echo
echo "Ensuring your Homebrew directory is writable..."
sudo chown -R $(whoami) /usr/local/bin

echo
echo "Installing Homebrew services..."
brew tap homebrew/services

echo
echo "Upgrading existing brews..."
brew upgrade

echo "Cleaning up your Homebrew installation..."
brew cleanup

echo
echo "Adding Homebrew's sbin to your PATH..."
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile

echo "Installing cask & wget"
brew tap caskroom/cask
brew install wget

# Core Apps
echo "Installing core apps"
brew cask install iterm2
brew cask install java

# Browsers
echo "Installing browsers"
brew cask install google-chrome
brew cask install firefox

# Communication
echo "Installing slack"
brew cask install slack

# Dev Tools
echo "Installing Dev Tools"
brew install git
brew cask install sublime-text
brew cask install atom
brew cask install insomnia
brew cask install macdown
brew install heroku-toolbelt
brew cask install expo-xde
heroku update
brew install docker
brew cask install postgres

# Graphic Apps
echo "Installing Graphic Apps"
brew cask install sketch

# Node
echo "==> preparing node etc for immersive"
echo "Installing NodeJS"
brew install node
echo "Installing PostgreSQL"
brew install postgres
#brew install watchman
echo "Installing Redis"
brew install redis
echo "Installing MongoDB"
brew cask install mongodb
echo "Installing Yarn"
brew install yarn

# Android
echo "==> preparing for android dev"
echo "Installing android-sdk"
brew cask install android-sdk
echo "Installing android-studio"
brew cask install android-studio
#echo "Installing genymotion"
#brew cask install genymotion
echo "Installing vysor"
brew cask install vysor

# NPM Packages
echo "==> preparing and installing npm packages"
npm install -g sequelize-cli
npm install -g nodemon
npm install -g pm2
npm install -g create-react-app
npm install -g create-react-native-app
npm install -g react-native-cli
npm install -g mocha
npm install -g jest
npm install -g firebase-tools
npm install -g aws-sdk
npm install -g vue-cli
npm install -g express-generator
npm install -g exp

# Dock Cleanup
echo "A cool Dock is in the making..."

defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Sublime Text.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Atom.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Insomnia.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Expo XDE.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

killall Dock

# Preventing lockscreen
echo "preventing lockscreen"

user_dis=$(ls -l /dev/console | awk {' print $3' })

path_dis = "/Users/$user_dis/Library/Preferences/com.apple.screensaver"

defaults write "$path_dis" askForPassword -int 0
defaults write "$path_dis" idleTime -int 7200
defaults write "$path_dis" askForPassword -bool false

chown $user_dis:staff $path_dis.plist

# Deep Freeze
echo "deepfreezing this mac..."
echo "downloading cloudagent"
wget https://github.com/akbarsahata/setup/raw/master/Installer.zip
echo "installing cloudagent"
unzip -a Installer.zip -d ~/Desktop
sudo installer -pkg ~/Desktop/CloudAgent.pkg -target /
echo "downloading deep freeze mac"
wget https://github.com/akbarsahata/setup/raw/master/Faronics_DFM.dmg
mv ./Faronics_DFM.dmg ~/Desktop
echo "mounting deep freeze mac"
hdiutil attach ~/Desktop/Faronics_DFM.dmg

# Disable Wifi and Hide the Icon

# Reverse Mouse Scroll Direction

# Git Alias
echo
echo "Setting up Git aliases..."
git config --global alias.gst git status
git config --global alias.st status
git config --global alias.di diff
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch
git config --global alias.sta stash
git config --global alias.llog "log --date=local"
git config --global alias.flog "log --pretty=fuller --decorate"
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.lol "log --graph --decorate --oneline"
git config --global alias.lola "log --graph --decorate --oneline --all"
git config --global alias.blog "log origin/master... --left-right"
git config --global alias.ds diff --staged
git config --global alias.fixup commit --fixup
git config --global alias.squash commit --squash
git config --global alias.unstage reset HEAD
git config --global alias.rum "rebase master@{u}"
echo "#Git" >> ~/.bash_it/aliases/enabled/general.aliases.bash
echo "alias gst='git status'" >> ~/.bash_it/aliases/enabled/general.aliases.bash

# Cleanup
brew cleanup

echo
echo "Finished! Enjoy your new computer!"
