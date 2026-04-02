# Dotfiles

Personal configuration files for zsh, fish, and Neovim.

```
.
├── scripts/
│   ├── utils.sh              — shared OS detection and helpers
│   ├── install-cli-tools.sh  — fzf, zoxide, eza, bat, ripgrep
│   ├── install-zsh.sh
│   ├── install-fish.sh
│   ├── install-nvim.sh
│   ├── install-docker.sh
│   ├── install-ruby.sh
│   └── install-homebrew.sh
├── zsh/
│   ├── .zshrc.mac
│   └── .zshrc.linux
├── fish/
│   ├── config.fish.mac
│   └── config.fish.linux
└── nvim/
```

All scripts support macOS (Homebrew) and Linux (apt). All scripts are safe to re-run — they skip anything already installed.

---

## Install

### Everything at once

```bash
bash install.sh
```

### Individual scripts

```bash
bash scripts/install-homebrew.sh
bash scripts/install-ruby.sh
bash scripts/install-cli-tools.sh
bash scripts/install-zsh.sh
bash scripts/install-fish.sh
bash scripts/install-nvim.sh
bash scripts/install-docker.sh
bash scripts/install-kubernetes.sh
```

All scripts are safe to re-run — they skip anything already installed.

---

## CLI Tools

| Tool | Description |
|------|-------------|
| `fzf` | Fuzzy finder — `Ctrl+R`, `Ctrl+T`, `Alt+C` |
| `zoxide` | Smarter `cd` with frecency-based jumping (`z`, `zi`) |
| `eza` | Modern `ls` replacement with icons and git integration |
| `bat` | Better `cat` with syntax highlighting |
| `ripgrep` | Fast recursive search, used as fzf file source |

`bat` and `ripgrep` are paired with `fzf` — ripgrep is used as the file source and bat renders the preview pane.

On Linux, apt is updated, upgraded, and autoremovedclean before installing.

---

## Zsh

Installs and configures zsh with:

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme
- Plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `web-search`, `git`

The correct `.zshrc` for your OS is copied to `~/.zshrc`. Any existing file is backed up as `~/.zshrc.bak.<timestamp>`. On first launch, Powerlevel10k will walk you through prompt configuration.

---

## Fish

Installs and configures fish with:

- [Fisher](https://github.com/jorgebucaran/fisher) — plugin manager
- [Tide](https://github.com/IlanCosman/tide) — prompt (equivalent to Powerlevel10k)
- [fzf.fish](https://github.com/PatrickF1/fzf.fish) — fzf integration

Syntax highlighting and autosuggestions are built into fish — no plugins needed. The correct `config.fish` for your OS is copied to `~/.config/fish/config.fish`. On first launch, Tide will walk you through prompt configuration.

---

## Neovim

Uses [LazyVim](https://lazyvim.github.io) as the base configuration. The install script backs up any existing `~/.config/nvim` and copies the config. Open Neovim after install and LazyVim will automatically install all plugins.

---

## Docker

- macOS: installs Docker Desktop via Homebrew Cask
- Linux: installs Docker Engine from the official Docker apt repository. Log out and back in after install for group permissions to take effect.

---

## Ruby

Installs Ruby via Homebrew (macOS) or `ruby-full` via apt (Linux). Required for any gem-based tools. The `~/.gem/bin` path is included in both shell configs so gem binaries are available on the PATH.
