if [ $# -eq 0 ]; then
    # Print warning if no argument given
    echo "Welcome to watch_tests.sh"
    echo "This script takes a directory name as an argument."
    echo "Then it runs unit tests whenever YAML files change."
    echo "No arguments given to watch_tests.sh."
    echo "Try it like this: sh watch_tests.sh strings"

elif [ ! -d "exercises/$1" ]; then
    # Print warning if directory not found
    echo "Welcome to watch_tests.sh"
    echo "This script takes a directory name as an argument."
    echo "Then it runs unit tests whenever YAML files change."
    echo "Unable to locate directory at exercises/$1"
    echo "Make sure you are executing this command from"
    echo "the root of the course's GitLab labs directory."
    echo "Try it like this: sh watch_tests.sh strings"

elif [ ! $(which watchexec) ]; then
    echo ""
    echo "Unable to find watchexec."
    echo "You will need this command to run this script."
    echo "You should install it with homebrew per the"
    echo "watchexec installation lesson."
    echo ""
    echo "You should follow that lesson and then run the script again."
    echo ""

elif [ ! $(which helm) ]; then

	echo ""
	echo "Unable to find helm."
	echo "You should install it with homebrew per the"
	echo "macOS Helm CLI installation lesson."
	echo ""
	echo "You should follow that lesson and then run the script again."
	echo ""

elif [ $(helm plugin list | grep -c unittest) -eq 0 ]; then

	echo ""
	echo "Unable to find helm unittest in output of helm plugin list."
	echo "You should install it with homebrew per the"
	echo "Helm Unit Test plugin installation lesson."
	echo ""
	echo "You should follow that lesson and then run the script again."
	echo ""

else
    watchexec -e yaml -- "helm unittest exercises/$1"
fi
