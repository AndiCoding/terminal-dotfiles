# terminal-dotfiles

A batteries-included terminal setup for macOS and Linux. One script installs your shell, editor, multiplexer, and development tools — and leaves any existing configs untouched. All scripts are safe to re-run — already-installed tools and plugins are skipped, not updated.

```
.
├── install.sh
├── scripts/
│   ├── utils.sh
│   ├── install-homebrew.sh
│   ├── install-ruby.sh
│   ├── install-cli-tools.sh
│   ├── install-zsh.sh
│   ├── install-fish.sh
│   ├── install-nvim.sh
│   ├── install-tmux.sh
│   ├── install-docker.sh
│   ├── install-kubernetes.sh
│   ├── install-gh.sh
│   ├── install-lazygit.sh
│   └── install-ghostty.sh
├── zsh/
│   ├── .zshrc.mac
│   └── .zshrc.linux
├── fish/
│   ├── config.fish.mac
│   └── config.fish.linux
├── tmux/
│   └── .tmux.conf
├── nvim/
└── ghostty/
    └── config
```

---

## Contents

- [Install](#install)
- [Shells](#shells)
  - [Zsh](#zsh)
  - [Fish](#fish)
- [Tools](#tools)
  - [CLI Tools](#cli-tools)
  - [Neovim](#neovim)
  - [tmux](#tmux)
  - [Ghostty](#ghostty)
  - [Docker](#docker)
  - [Kubernetes](#kubernetes)
  - [GitHub CLI](#github-cli)
  - [lazygit](#lazygit)
  - [Ruby](#ruby)

---

## Install

```bash
bash install.sh
```

> Or make it executable first: `chmod +x install.sh && ./install.sh`

The installer will ask you to:
1. Choose a default shell — zsh or fish
2. Select optional tools via an interactive checklist (all pre-selected)

If a config file already exists on your system it will not be overwritten — the installer skips the copy and uses what you have.

### Individual scripts

Each tool can also be installed standalone:

```bash
bash scripts/install-homebrew.sh
bash scripts/install-ruby.sh
bash scripts/install-cli-tools.sh
bash scripts/install-zsh.sh
bash scripts/install-fish.sh
bash scripts/install-nvim.sh
bash scripts/install-tmux.sh
bash scripts/install-docker.sh
bash scripts/install-kubernetes.sh
bash scripts/install-gh.sh
bash scripts/install-lazygit.sh
bash scripts/install-ghostty.sh
```

---

## Shells

### Zsh

Installs zsh with [Oh My Zsh](https://ohmyz.sh/), the [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme, and the following plugins:

- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `web-search`
- `git`

On first launch, Powerlevel10k will walk you through prompt configuration.

### Fish

Installs fish with [Fisher](https://github.com/jorgebucaran/fisher) as the plugin manager and:

- [Tide](https://github.com/IlanCosman/tide) — prompt (equivalent to Powerlevel10k)
- [fzf.fish](https://github.com/PatrickF1/fzf.fish) — fzf keybindings and completions

Syntax highlighting and autosuggestions are built into fish — no plugins needed. On first launch, Tide will walk you through prompt configuration.

---

## Tools

### CLI Tools

Installed automatically as a dependency via `install-cli-tools.sh`.

| Tool | Description |
|------|-------------|
| `fzf` | Fuzzy finder — `Ctrl+R` history, `Ctrl+T` files, `Alt+C` directories |
| `zoxide` | Smarter `cd` with frecency-based jumping (`z`, `zi`) |
| `eza` | Modern `ls` replacement with icons and git integration |
| `bat` | `cat` with syntax highlighting and line numbers |
| `ripgrep` | Fast recursive search, used as the fzf file source |

### Neovim

Uses [LazyVim](https://lazyvim.github.io) as the base configuration. Open Neovim after install and LazyVim will automatically bootstrap all plugins.

### tmux

Installs tmux with [TPM](https://github.com/tmux-plugins/tpm) and the following plugins:

| Plugin | Description |
|--------|-------------|
| `tmux-sensible` | Sensible default settings |
| `tmux-resurrect` | Save and restore sessions across restarts |
| `tmux-continuum` | Auto-saves sessions every 5 minutes |

`Prefix` is `Ctrl+a`. Split panes with `Prefix + |` (vertical) and `Prefix + -` (horizontal). Navigate with `Prefix + h/j/k/l`. Reload config with `Prefix + r`.

### Ghostty

Installs [Ghostty](https://ghostty.org) via Homebrew Cask (macOS only) and copies a config with sensible defaults: JetBrains Mono Nerd Font, Catppuccin Mocha theme, and transparent window decorations.

### Docker

- macOS: installs Docker Desktop via Homebrew Cask
- Linux: installs Docker Engine from the official Docker apt repository. Log out and back in after install for group permissions to take effect.

### Kubernetes

Installs `kubectl`, `helm`, and a local cluster runtime — `k3s` on Linux, `k3d` on macOS (k3s is not supported natively on macOS; k3d runs it inside Docker).

### GitHub CLI

Installs [`gh`](https://cli.github.com) for managing pull requests, issues, and releases from the terminal.

### lazygit

A terminal UI for git with a visual diff viewer, staging, branching, and rebase support. Installed via Homebrew on macOS, or fetched from the latest GitHub release on Linux.

### Ruby

Installs Ruby via Homebrew (macOS) or `ruby-full` via apt (Linux). The `~/.gem/bin` path is included in both shell configs so gem binaries are available on `PATH`.
