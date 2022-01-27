#!/bin/sh
#version: 01
#based on: https://github.com/CriticalPathSecurity/Zeek-Intelligence-Feeds


# notes:
## zeek intel files location: /usr/local/zeek/share/zeek/site/Zeek-Intelligence-Feeds


cd /usr/local/zeek/share/zeek/site/Zeek-Intelligence-Feeds && git fetch origin master
git reset --hard FETCH_HEAD
git clean -df 

echo ""
echo "Zeek-Intelligence-Feeds updated."
echo ""