#!/bin/sh

set -e

sudo -u $(stat -f "%Su" /dev/console) /bin/sh <<'END'

__dock_item() {
	printf '%s%s%s%s%s' \
		   '<dict><key>tile-data</key><dict><key>file-data</key><dict>' \
		   '<key>_CFURLString</key><string>' \
		   "$1" \
		   '</string><key>_CFURLStringType</key><integer>0</integer>' \
		   '</dict></dict></dict>'
}

# delete current dock
defaults delete com.apple.dock persistent-apps

# load dock items
printf '%s' 'Setting up Dock icons...'
defaults write com.apple.dock \
			   persistent-apps -array "$(__dock_item /Applications/Self-Service.app)" \
									  "$(__dock_item /Applications/Microsoft\ Edge.app)" \
									  "$(__dock_item /Applications/Microsoft\ Outlook.app)" \
									  "$(__dock_item /Applications/Microsoft\ Excel.app)" \
									  "$(__dock_item /Applications/Microsoft\ PowerPoint.app)" \
									  "$(__dock_item /Applications/Microsoft\ Word.app)" \
									  "$(__dock_item /Applications/Microsoft\ Teams.app)" \
									  "$(__dock_item /Applications/Webex.app)" \
									  "$(__dock_item ~/Applications/Slack.app)" \
									  "$(__dock_item /System/Applications/System\ Settings.app)"       
killall Dock
printf '%s\n' ' done.'