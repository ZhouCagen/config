#!/usr/bin/env fish

set pattern 'WXWork|WXWorkWeb|WXDrive|WeMail|WeMeet|wemeet|wwmapp|XnnExternal'

echo "TERM WXWork..."
pgrep -f $pattern | xargs -r kill -TERM

sleep 2

echo "KILL WXWork..."
pgrep -f $pattern | xargs -r kill -KILL

sleep 1

echo "KILL wineserver..."
pkill -KILL wineserver

echo "remaining:"
pgrep -af "$pattern|wineserver"
