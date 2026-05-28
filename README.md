# mac-dotfiles

Mac pentest workstation config. Symlinked via `install.sh`.

## What's included

| Config | Location |
|--------|----------|
| zsh + oh-my-zsh | `~/.zshrc` |
| ohmy-pentest-report theme (macOS patched) | `~/.oh-my-zsh/custom/themes/` |
| AeroSpace tiling WM | `~/.aerospace.toml` |
| Sketchybar status bar | `~/.config/sketchybar/` |
| Neovim / LazyVim | `~/.config/nvim/` |
| tmux | `~/.tmux.conf` |

## Install

```bash
git clone https://github.com/Tannahsheen/mac-dotfiles ~/mac-dotfiles
bash ~/mac-dotfiles/install.sh
```

Existing files are backed up as `<file>.bak` before being replaced.

## Shell theme

Uses [ohmy-pentest-report](https://deephacking.tech/) with macOS fixes:
- `enableall` — show date + local IP in prompt
- `setip <interface|ip|public>` — pin IP in prompt
- `disableall` — clean prompt

## Sketchybar layout

```
[1] [2] [3]  AppName          vpn: 100.x.x.x  14:23  67%
```

Workspace pills highlight on focus via AeroSpace event hook.
VPN indicator reads from Tailscale (utun5).

## Requirements

- [oh-my-zsh](https://ohmyz.sh/)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [Sketchybar](https://github.com/FelixKratz/SketchyBar)
- Hack Nerd Font (`brew install --cask font-hack-nerd-font`)

All installed automatically via [mac-bootstrap](https://github.com/Tannahsheen/mac-bootstrap).
