# Declare path as the first param
[CmdLetbinding()]
param(
[string]$path
)

Write-Host "Welcome to watch_tests.ps1."

if (-Not (docker ps)) {
	Write-Host ""
	Write-Host "Docker is not running. Unfortunately, as of writing,"
	Write-Host "you need Docker to run helm unittest on windows."
	Write-Host "Helm unittest, as of writing, requires a Bourne shell (sh)."
	Write-Host "There is a workaround using WSL2, but"
	Write-Host "you are already running docker so we will use"
	Write-Host "that option for unit tests."
	Write-Host ""
	Write-Host "Go ahead and start Docker Desktop and try the command again."
	Write-Host ""
} elseif (-Not (Get-Command "watchexec")) {
	Write-Host ""
	Write-Host "Unable to find watchexec."
	Write-Host "You will need this command to run this script."
	Write-Host "You should install it with chocolatey per the"
	Write-Host "watchexec installation lesson."
	Write-Host ""
	Write-Host "You should follow that lesson and then run the script again."
	Write-Host ""
} elseif (-Not (Get-Command "helm")) {
	Write-Host ""
	Write-Host "Unable to find helm."
	Write-Host "You should install it with chocolatey per the"
	Write-Host "Windows Helm CLI installation lesson."
	Write-Host ""
	Write-Host "You should follow that lesson and then run the script again."
	Write-Host ""

} elseif ($path) {

	$current_directory = -join((pwd).Path, "\exercises\", $path)
	if (Test-Path $current_directory) {
		# Path exists
		Write-Host "About to run tests with watchexec for directory:"
		Write-Host $current_directory
		Write-Host ""
		Write-Host "Full command:"
		Write-Host "watchexec -e yaml -- ""docker run -ti --rm -v ${current_directory}:/apps helmunittest/helm-unittest:latest ."""

		# The actual command
		watchexec -e yaml -- "docker run -ti --rm -v ${current_directory}:/apps helmunittest/helm-unittest:latest ."

	} else {
		# Path doesn't exist, error out
		Write-Host "This script takes a directory name as an argument."
		Write-Host "The script runs Helm unit tests whenever YAML files change."
		Write-Host "We were unable to find the directory ${current_directory}"
		Write-Host "The argument should be one of the charts in the exercises folder."
		Write-Host "Make sure you are executing this command from"
		Write-Host "The root of this course's GitLab labs directory."
		Write-Host "Try it like this: .\watch_tests.bat strings"
		Write-Host ""
	}

} else {
	Write-Host "This script takes a directory name as an argument."
	Write-Host "The script runs Helm unit tests whenever YAML files change."
	Write-Host "No arguments given to watch_tests.bat"
	Write-Host "The argument should be one of the charts in the exercises folder."
	Write-Host "Try it like this: .\watch_tests.bat strings"
	Write-Host ""
}

