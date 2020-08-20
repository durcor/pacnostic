#!/bin/sh
# A library for calling the system's primary package manager written in POSIX shell

case "$(uname)" in
	"Linux")
		case "$(awk -F'=' '/^NAME/{print $2}' /etc/os-release)" in
			'"Arch Linux"')
				if pacman -Qq yay >/dev/null; then
					PACNOSTIC_INSTALL="yay -Syu"
					PACNOSTIC_REMOVE="yay -Rs"
					PACNOSTIC_SEARCH="yay"
					PACNOSTIC_UPDATE="yay"
					PACNOSTIC_FIND_FILE="yay -F"
				else
					PACNOSTIC_INSTALL="sudo pacman -Syu"
					PACNOSTIC_REMOVE="sudo pacman -Rs"
					PACNOSTIC_SEARCH="pacman -Ss"
					PACNOSTIC_UPDATE="$PACNOSTIC_INSTALL"
					PACNOSTIC_FIND_FILE="pacman -F"
				fi
				;;
			'"Gentoo"')
				PACNOSTIC_INSTALL="sudo emerge"
				PACNOSTIC_REMOVE="sudo emerge --deselect"
				PACNOSTIC_SEARCH="emerge --search"
				PACNOSTIC_UPDATE="sudo emerge --update @world"
				;;
			'"Ubuntu"')
				PACNOSTIC_INSTALL="sudo apt install"
				PACNOSTIC_REMOVE="sudo apt remove"
				;;
			'"Fedora"')
				PACNOSTIC_INSTALL="sudo dnf install"
				PACNOSTIC_REMOVE="sudo dnf remove"
				;;
			'"OpenSUSE"')
				PACNOSTIC_INSTALL="sudo zypper install"
				PACNOSTIC_REMOVE="sudo zypper remove"
				;;
			*)
				echo "Unsupported Linux distro"
				exit 1
				;;
		esac
		;;
	"Darwin")
		command -v brew >/dev/null || bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		PACNOSTIC_INSTALL="brew install"
		PACNOSTIC_REMOVE="brew remove"
		;;
	*)
		echo "Unsupported operating system"
		exit 1
		;;
esac

[ "$1" = "debug" ] && {
	echo "install command = $PACNOSTIC_INSTALL"
	echo "remove command = $PACNOSTIC_REMOVE"
	echo "search command = $PACNOSTIC_SEARCH"
	echo "update command = $PACNOSTIC_UPDATE"
	echo "find file command = $PACNOSTIC_FIND_FILE"
}
