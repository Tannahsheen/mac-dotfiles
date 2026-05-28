#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

symlink() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "  backup: $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    ln -sf "$src" "$dst"
    echo "  linked: $dst"
}

echo "==> zsh"
symlink "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
symlink "$DOTFILES/zsh/themes/ohmy-pentest-report.zsh-theme" \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/ohmy-pentest-report.zsh-theme"

echo "==> aerospace"
symlink "$DOTFILES/aerospace/aerospace.toml" "$HOME/.aerospace.toml"

echo "==> sketchybar"
symlink "$DOTFILES/sketchybar/sketchybarrc" "$HOME/.config/sketchybar/sketchybarrc"
for plugin in "$DOTFILES/sketchybar/plugins/"*.sh; do
    symlink "$plugin" "$HOME/.config/sketchybar/plugins/$(basename "$plugin")"
done
chmod +x "$DOTFILES/sketchybar/plugins/"*.sh

echo "==> nvim"
symlink "$DOTFILES/nvim/lua/plugins/colorscheme.lua" \
        "$HOME/.config/nvim/lua/plugins/colorscheme.lua"

echo "==> tmux"
symlink "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo ""
echo "done."
