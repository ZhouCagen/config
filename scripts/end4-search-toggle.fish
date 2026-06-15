#!/usr/bin/env fish

set flag /tmp/end4-super-alone

if test "$argv[1]" = press
    touch "$flag"
    exit 0
end

if test "$argv[1]" = interrupt
    rm -f "$flag"
    exit 0
end

if test "$argv[1]" = release
    if test -f "$flag"
        rm -f "$flag"
        hyprctl dispatch global quickshell:searchToggle
    end
    exit 0
end
