#!/bin/zsh

logger "Total Arguments: $#" 4

while test $# -gt 0; do
	case "$1" in
		-v|--version)
			echo "Version: $VERSION"
			exit 0
		;;
		-h|--help)
			echo "$BINNAME - ADE Deployment Tool"
			echo " "
			echo "$package [deploy|predeploy|both] --options"
			echo " "
			echo "options:"
			echo "-h, --help                show brief help"
			echo "-v, --version       		show bin version"
			echo "-pdt, --predeploytool=JamfConnect       specify an arg with variable"
			exit 0
		;;
		-pdt)
			shift
			if test $# -gt 0; then
				export PROCESS=$1
			else
				echo "no process specified"
				exit 1
			fi
			shift
		;;
		--predeploy*)
			export PROCESS=`echo $1 | sed -e 's/^[^=]*=//g'`
			shift
		;;
		-o)
			shift
			if test $# -gt 0; then
				export OUTPUT=$1
			else
				echo "no output dir specified"
				exit 1
			fi
			shift
		;;
		--output-dir*)
			export OUTPUT=`echo $1 | sed -e 's/^[^=]*=//g'`
			shift
		;;
		*)
			break
		;;
	esac
done