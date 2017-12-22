echo "preventing lockscreen"

user_dis=$(ls -l /dev/console | awk {' print $3' })

path_dis = "/Users/$user_dis/Library/Preferences/com.apple.screensaver"

defaults write "$path_dis" askForPassword -int 0
defaults write "$path_dis" idleTime -int 7200
defaults write "$path_dis" askForPassword -bool false

chown $user_dis:staff $path_dis.plist