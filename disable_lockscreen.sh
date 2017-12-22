user=$(ls -l /dev/console | awk {' print $3' })

path = "/Users/$user/Library/Preferences/com.apple.screensaver"

defaults write "$path" askForPassword -int 0
defaults write "$path" idleTime -int 7200
defaults write "$path" askForPassword -bool false

chown $user:staff $path.plist