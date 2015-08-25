set AirplayDeviceName to "HK Aura WF"
set PlaylistName to "alarm"

tell application "System Preferences"
	reveal anchor "output" of pane id "com.apple.preference.sound"
	#activate
	
	tell application "System Events"
		tell process "System Preferences"
			select (row 1 of table 1 of scroll area 1 of tab group 1 of window "Sound" whose value of text field 1 is AirplayDeviceName)
		end tell
	end tell
	
	quit
end tell

delay 2.0
set volume output volume 40 --100%

activate application "iTunes"
delay 1.0

tell application "System Events" to perform action "AXPress" of (first menu item of process "iTunes"'s menu bar 1's menu bar item "Controls"'s menu 1's menu item "Repeat"'s menu 1 whose name ends with "All")
tell application "System Events" to perform action "AXPress" of (first menu item of process "iTunes"'s menu bar 1's menu bar item "Controls"'s menu 1's menu item "Shuffle"'s menu 1 whose name ends with "On")

tell application "iTunes"
	try
		play playlist PlaylistName
		
		set currentVolume to 10
		repeat while currentVolume ² 100
			set the sound volume to currentVolume
			set currentVolume to currentVolume + 10
			delay 10.0
		end repeat
	on error
		set the sound volume to 100
		set backupFile to POSIX file "/System/Library/Sounds/Sosumi.aiff"
		open backupFile
	end try
end tell