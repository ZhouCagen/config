#!/usr/bin/env fish

set -l desktopId com.qq.weixin.work.deepin
set -l logFile /tmp/wecom-autofix.log

for dep in hyprctl jq gtk-launch
    if not command -q $dep
        echo "缺少依赖: $dep"
        exit 1
    end
end

gtk-launch $desktopId >$logFile 2>&1 &

# 最多等 8 秒，只关一次，避免把主窗口也关掉
for i in (seq 1 32)
    sleep 0.25

    set -l addr (hyprctl clients -j | jq -r '
        def s(x): (x // "" | tostring);
        def lower(x): (s(x) | ascii_downcase);

        def hasWecomName(x):
            (lower(x) | contains("weixin")) or
            (lower(x) | contains("wxwork")) or
            (lower(x) | contains("wework")) or
            (lower(x) | contains("wecom")) or
            (lower(x) | contains("wechat work")) or
            (s(x) | contains("企业微信"));

        def isWecom:
            hasWecomName(.class) or
            hasWecomName(.initialClass) or
            hasWecomName(.title) or
            hasWecomName(.initialTitle);

        def emptyTitle:
            ((s(.title) | gsub("[[:space:]]"; "") | length) == 0);

        def area:
            ((.size[0] // 999999) * (.size[1] // 999999));

        . as $all |
        ($all | map(select(isWecom))) as $wecom |
        ($wecom | map(select(emptyTitle))) as $empty |
        ($wecom | map(select(emptyTitle | not))) as $normal |

        if (($normal | length) >= 1 and ($empty | length) >= 1) then
            ($empty | sort_by(area) | .[0].address)
        else
            empty
        end
    ')

    if test -n "$addr"
        echo "closing black window: $addr" >>$logFile
        hyprctl dispatch closewindow "address:$addr" >/dev/null 2>&1
        exit 0
    end
end

echo "no safe black window found" >>$logFile
