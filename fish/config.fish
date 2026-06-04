# =========================================================
# Fish Shell 配置文件
# =========================================================
# 这个文件会在 fish 启动时加载。
# 适合放：
# - 交互式终端配置
# - prompt 配置
# - alias / abbr 快捷命令
# - 颜色配置
# - 一些只想在终端里生效的设置

# =========================================================
# 只在交互式终端中运行
# =========================================================
# status is-interactive 表示当前 fish 是用户正在操作的终端。
# 这样可以避免脚本执行 fish 时也加载这些交互式配置。
if status is-interactive

    # =====================================================
    # 关闭 fish 默认欢迎语
    # =====================================================
    # fish 默认启动时可能会显示欢迎信息。
    # 设置为空即可关闭。
    set fish_greeting

    # =====================================================
    # Starship Prompt 配置
    # =====================================================
    # starship 是你的终端提示符。
    # 这里配置的是 transient prompt，也就是执行命令后，
    # 旧 prompt 会被简化，只保留一个符号，终端看起来更清爽。
    function starship_transient_prompt_func
        starship module character
    end

    # 如果当前不是纯 TTY 控制台，也就是不是 Ctrl + Alt + F2 那种 linux 终端，
    # 就启用 starship。
    #
    # TERM=linux 通常表示纯 TTY。
    # 在 TTY 里启用某些 fancy prompt 可能显示异常，所以这里跳过。
    if test "$TERM" != linux
        starship init fish | source
        enable_transience
    end

    # =====================================================
    # 终端颜色配置
    # =====================================================
    # quickshell / end4 可能会生成一份终端颜色 escape sequence。
    # 如果这个文件存在，就输出它，让终端应用对应配色。
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # =====================================================
    # 常用 Alias
    # =====================================================

    # kitty 里普通 clear 有时候清不干净滚动缓冲区。
    # 这个 clear 会同时清屏、清滚动缓冲区，并把光标移动到左上角。
    alias clear "printf '\033[2J\033[3J\033[1;1H'"

    # 防手滑：clear 常见打错版本
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"

    # 防手滑：pacman 打成 pamcan 时也能正常执行
    alias pamcan pacman

    # quickshell 快捷命令
    # q 输入后等价于 qs -c ii
    alias q 'qs -c ii'

    # 如果不是纯 TTY，就用 eza 替代 ls，并显示图标。
    # TTY 下可能没有 Nerd Font 图标，所以不启用。
    if test "$TERM" != linux
        alias ls 'eza --icons'
    end

    # 如果当前终端是 kitty，就用 kitten ssh。
    # kitten ssh 可以改善远程连接时的终端体验。
    if test "$TERM" = xterm-kitty
        alias ssh 'kitten ssh'
    end

    # =====================================================
    # Power Profiles 电源模式快捷命令
    # =====================================================
    # 需要先安装并启用：
    # sudo pacman -S power-profiles-daemon python-gobject upower
    # sudo systemctl enable --now power-profiles-daemon.service
    #
    # 用法：
    # ppp  -> performance 性能模式
    # ppb  -> balanced 平衡模式
    # pps  -> power-saver 省电模式
    # ppg  -> 查看当前电源模式
    # ppl  -> 查看支持的电源模式列表

    alias ppp 'powerprofilesctl set performance'
    alias ppb 'powerprofilesctl set balanced'
    alias pps 'powerprofilesctl set power-saver'
    alias ppg 'powerprofilesctl get'
    alias ppl 'powerprofilesctl list'

end
