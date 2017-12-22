echo "deepfreezing this mac..."
echo "downloading cloudagent"
wget https://github.com/akbarsahata/setup/raw/master/Installer.zip
echo "installing cloudagent"
unzip -a Installer.zip -d ~/Desktop
sudo installer -pkg ~/Desktop/CloudAgent.pkg -target /
echo "downloading deep freeze mac"
wget https://github.com/akbarsahata/setup/raw/master/Faronics_DFM.dmg
echo "mounting deep freeze mac"
hdiutil attach ./Faronics_DFM.dmg
