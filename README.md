# terminal-dotfiles

Personal terminal configuration for zsh, fish, Neovim, and tmux.

```
.
├── install.sh
├── scripts/
│   ├── utils.sh
│   ├── install-cli-tools.sh
│   ├── install-zsh.sh
│   ├── install-fish.sh
│   ├── install-nvim.sh
│   ├── install-docker.sh
│   ├── install-kubernetes.sh
│   ├── install-gh.sh
│   ├── install-tmux.sh
│   ├── install-lazygit.sh
│   ├── install-ruby.sh
│   └── install-homebrew.sh
├── zsh/
│   ├── .zshrc.mac
│   └── .zshrc.linux
├── fish/
│   ├── config.fish.mac
│   └── config.fish.linux
├── tmux/
│   └── .tmux.conf
└── nvim/
```

All scripts support macOS (Homebrew) and Linux (apt). All scripts are safe to re-run — they skip anything already installed.

---

## Install

### Everything at once

```bash
bash install.sh
```

The installer will prompt you to:
1. Choose a default shell — zsh or fish
2. Select optional tools to install (0 for all)

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
bash scripts/install-gh.sh
bash scripts/install-tmux.sh
bash scripts/install-lazygit.sh
```

---

## CLI Tools

Installed via `install-cli-tools.sh`. `bat` and `ripgrep` are paired with `fzf` — ripgrep is used as the file source and bat renders the preview pane.

| Tool | Description |
|------|-------------|
| `fzf` | Fuzzy finder — `Ctrl+R`, `Ctrl+T`, `Alt+C` |
| `zoxide` | Smarter `cd` with frecency-based jumping (`z`, `zi`) |
| `eza` | Modern `ls` replacement with icons and git integration |
| `bat` | Better `cat` with syntax highlighting |
| `ripgrep` | Fast recursive search, used as fzf file source |

---

## Zsh

Installs and configures zsh with:

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme
- Plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `web-search`, `git`

The correct `.zshrc` for your OS is copied to `~/.zshrc`. On first launch, Powerlevel10k will walk you through prompt configuration.

---

## Fish

Installs and configures fish with:

- [Fisher](https://github.com/jorgebucaran/fisher) — plugin manager
- [Tide](https://github.com/IlanCosman/tide) — prompt (equivalent to Powerlevel10k)
- [fzf.fish](https://github.com/PatrickF1/fzf.fish) — fzf integration

Syntax highlighting and autosuggestions are built into fish — no plugins needed. The correct `config.fish` for your OS is copied to `~/.config/fish/config.fish`. On first launch, Tide will walk you through prompt configuration.

---

## Neovim

Uses [LazyVim](https://lazyvim.github.io) as the base configuration. Open Neovim after install and LazyVim will automatically install all plugins.

---

## tmux

Installs tmux with [TPM](https://github.com/tmux-plugins/tpm) and the following plugins:

| Plugin | Description |
|--------|-------------|
| `tmux-sensible` | Sensible default settings |
| `tmux-resurrect` | Save and restore sessions across restarts |
| `tmux-continuum` | Auto-saves sessions every 5 minutes |

Key bindings: `Prefix` is `Ctrl+a`. Split with `Prefix + |` (horizontal) and `Prefix + -` (vertical). Navigate panes with `Prefix + h/j/k/l`. Reload config with `Prefix + r`.

---

## Docker

- macOS: installs Docker Desktop via Homebrew Cask
- Linux: installs Docker Engine from the official Docker apt repository. Log out and back in after install for group permissions to take effect.

---

## Kubernetes

Installs `kubectl`, `helm`, and `k3s` (Linux) or `k3d` (macOS). k3s is not supported on macOS — k3d runs k3s inside Docker instead.

---

## GitHub CLI

Installs `gh` for interacting with GitHub from the terminal.

---

## lazygit

Terminal UI for git. On Linux, fetches the latest release directly from GitHub. On macOS, installed via Homebrew.

---

## Ruby

Installs Ruby via Homebrew (macOS) or `ruby-full` via apt (Linux). The `~/.gem/bin` path is included in both shell configs so gem binaries are available on the PATH.
