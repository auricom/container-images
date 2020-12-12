#!/usr/bin/env bash

version=$(curl -sL https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux | awk -F '(download-cdn.resilio.com/|/Debian/)' '/x64/ {print $2}')
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
