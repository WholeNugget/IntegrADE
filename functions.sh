#!/bin/zsh

makeDirectory (){ # Check and create folder directories
	if [[ ! -d "${1}" ]];then 
		sudo mkdir -p "${1}"
	fi 
} # Usage: makeDirectory "/Users/localadmin/Desktop/test2/"

# This will be used later for easier management
getPref () { # Used to read preference & managed preference files
	plistDomain="com.litlabs.integrade"
	managedPrefs="/Library/Managed Preferences/$plistDomain.plist"
	localPrefs="/Library/Preferences/$plistDomain.plist"
	
	keyValue=$(defaults read "${managedPrefs}" $1 2>/dev/null)
	if [[ -z $keyValue ]]; then
		keyValue=$(defaults read "${localPrefs}" $1 2>/dev/null)
	fi
	echo "Your Key Value: $keyValue"
} # Usage: getPref MyKey

# LOGGING FUNCTION

logger () { # Used to write logs to file
	logMessage="$1"
	logLevel="$2"
	timestamp=$(date +%F\ %T)
	
	# Log Level Prefix
	case "$logLevel" in 
		1 ) # ERROR
			logPrefix="ERROR"
		;;
		2 ) # WARNING
			logPrefix="WARN "
		;;
		3 ) # INFO
			logPrefix="INFO "
		;;
		4 ) # DEBUG
			logPrefix="DEBUG"
		;;
	esac
	
	echo "$timestamp : $logPrefix >> $logMessage" >> $logFile
} #logger "Message goes here" 4