echo "deepfreezing this mac..."
wget https://github.com/akbarsahata/setup/raw/master/Installer.zip
unzip -a Installer.zip -d ~/Desktop
sudo installer -pkg ~/Desktop/CloudAgent.pkg -target /
