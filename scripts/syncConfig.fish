#!/usr/bin/env fish

set repoDir ~/Code/github/config
set timeNow (date "+%Y-%m-%d %H:%M:%S")

function syncDir --argument-names sourceDir targetDir
    if not test -d $sourceDir
        echo "Skip, not found: $sourceDir"
        return 0
    end

    mkdir -p $targetDir

    echo
    echo "Syncing:"
    echo "  from: $sourceDir"
    echo "  to:   $targetDir"

    rsync -av --delete \
        --exclude='.git/' \
        --exclude='.cache/' \
        --exclude='cache/' \
        --exclude='tmp/' \
        --exclude='temp/' \
        --exclude='*.log' \
        --exclude='node_modules/' \
        --exclude='.env' \
        --exclude='*.secret' \
        --exclude='*.token' \
        --exclude='*.key' \
        --exclude='id_rsa' \
        --exclude='id_rsa.pub' \
        $sourceDir/ $targetDir/
end

if not test -d $repoDir
    echo "Repo not found: $repoDir"
    exit 1
end

if not git -C $repoDir rev-parse --is-inside-work-tree >/dev/null 2>&1
    echo "Not a git repo: $repoDir"
    exit 1
end

echo
echo "Pulling latest config repo..."
git -C $repoDir pull --rebase origin main

if test $status -ne 0
    echo "Git pull failed: $repoDir"
    exit 1
end

# Neovim
syncDir ~/.config/nvim $repoDir/nvim

# fish
syncDir ~/.config/fish $repoDir/fish

# Hyprland / Wayland
syncDir ~/.config/hypr $repoDir/hypr
syncDir ~/.config/waybar $repoDir/waybar
syncDir ~/.config/rofi $repoDir/rofi
syncDir ~/.config/fuzzel $repoDir/fuzzel
syncDir ~/.config/mako $repoDir/mako
syncDir ~/.config/dunst $repoDir/dunst

# terminal
syncDir ~/.config/kitty $repoDir/terminal/kitty
syncDir ~/.config/alacritty $repoDir/terminal/alacritty
syncDir ~/.config/wezterm $repoDir/terminal/wezterm

# fcitx5
syncDir ~/.config/fcitx5 $repoDir/fcitx5

# scripts
syncDir ~/.Scripts $repoDir/scripts

# git config
mkdir -p $repoDir/git

if test -f ~/.gitconfig
    cp ~/.gitconfig $repoDir/git/.gitconfig
end

# Arch package lists
mkdir -p $repoDir/arch

pacman -Qqe >$repoDir/arch/pkglist-pacman.txt
pacman -Qqm >$repoDir/arch/pkglist-aur.txt

# Arch system config
mkdir -p $repoDir/arch/etc

if test -f /etc/pacman.conf
    cp /etc/pacman.conf $repoDir/arch/etc/pacman.conf
end

if test -f /etc/makepkg.conf
    cp /etc/makepkg.conf $repoDir/arch/etc/makepkg.conf
end

cd $repoDir

if test -n "$(git status --porcelain)"
    git add -A
    git commit -m "Sync Arch config: $timeNow"

    if test $status -ne 0
        echo "Git commit failed: $repoDir"
        exit 1
    end

    git push origin main

    if test $status -ne 0
        echo "Git push failed: $repoDir"
        exit 1
    end
else
    echo "No config changes"
end
