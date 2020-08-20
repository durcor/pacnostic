# Pacnostic
Distribution-agnostic POSIX shell-compliant library for interfacing with system package managers

# Installation
**MAKEFILE IN PROGRESS**

# Usage
This library can be run directly (ie. by attraching each package_manager_* variable to a shell alias) but its primary use-case would be for use as an operating system-agnostic means of interacting with the system's package manager.
This means the file should be sourced, either through
```sh
#!/bin/{bash,zsh,fish}
source /usr/lib/pacnostic.sh
```
or
```sh
#!/bin/sh
. /usr/lib/pacnostic.sh
```
After sourcing, if one wishes to interface with the system's package manager but is unsure of the operating system in use, they can simply reference one of
```sh
$PACNOSTIC_INSTALL
$PACNOSTIC_REMOVE
$PACNOSTIC_SEARCH
$PACNOSTIC_UPDATE
$PACNOSTIC_FIND_FILE
```