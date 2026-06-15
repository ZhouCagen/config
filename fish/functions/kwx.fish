function kwx --description 'kill 企业微信'
    set -l pattern 'WXWork|WXWorkWeb|WXDrive|WeMail|WeMeet|wemeet|wwmapp|XnnExternal'
    
    set -l pids (pgrep -f $pattern)
    if test (count $pids) -gt 0
        kill -TERM $pids 2>/dev/null
        sleep 1
    end
    
    set pids (pgrep -f $pattern)
    if test (count $pids) -gt 0
        kill -KILL $pids 2>/dev/null
    end
    
    pkill -KILL wineserver 2>/dev/null
    
    pgrep -af "$pattern|wineserver"
end
