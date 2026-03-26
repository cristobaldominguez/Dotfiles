# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

This is NOT an app, NOT a website, NOT a library. It's a personal Mac setup repository — a collection of configuration files and installation scripts that define exactly how Cristobal's Mac should be configured from scratch.

The purpose is simple: whenever a Mac needs to be set up (new machine, reinstall, reset), clone this repo from GitHub and run one script. Everything installs and configures itself in the right order, automatically.

**This repo lives on GitHub and is used as a restore point.** Changes made here represent intentional, permanent decisions about the development environment.

## Entry point: `install.sh`

This is THE file that matters. Everything starts here. The installation sequence is:

1. **Rosetta** — installs on Apple Silicon (ARM64) machines
2. **Xcode CLI tools** — required by everything else
3. **Homebrew** — with a health check before continuing
4. **Fonts** — Meslo LG Powerline fonts copied to `~/Library/Fonts`
5. **Oh-My-Zsh** — installed unattended (no interactive prompts)
6. **Terminal preferences** — restores `com.apple.Terminal.plist` to `~/Library/Preferences`
7. **Homebrew packages** — runs `brew bundle --file=./Brewfile` (all tools, casks, and taps)
8. **Zsh plugins** — clones 3 plugins into Oh-My-Zsh custom plugins directory (idempotent — skips if already exists):
   - `zsh-autosuggestions`
   - `zsh-syntax-highlighting`
   - `zsh-history-substring-search`
9. **Dotfiles** — copies config files directly to `$HOME`
10. **RVM + Ruby 3.3** — installs RVM stable via GPG + curl, then installs Ruby 3.3 with `openssl@3`
11. **Node LTS** — installs latest LTS via `fnm`

To run on a fresh Mac:

```bash
git clone <repo-url>
cd Dotfiles
./install.sh
```

## How dotfiles are deployed

There is no symlink manager. `install.sh` uses `cp` to copy files directly to `~`. The mapping is:

| Repo file | Destination |
|-----------|-------------|
| `zshrc` | `~/.zshrc` |
| `shortcuts` | `~/.shortcuts` |
| `zsh_customization` | `~/.zsh_customization` |
| `zsh_rvm` | `~/.zsh_rvm` |
| `gitconfig` | `~/.gitconfig` |
| `gitignore` | `~/.gitignore` |
| `gitattributes` | `~/.gitattributes` |
| `gemrc` | `~/.gemrc` |

After editing any of these files, the change only takes effect in the shell after re-running `install.sh` or manually copying the file to `$HOME`.

## Key files

- **`Brewfile`** — all Homebrew packages and casks. Add new tools here.
- **`zshrc`** — Oh-My-Zsh config, PATH exports, plugin list, tool initializations (fnm, fzf, bat, terraform, pnpm).
- **`shortcuts`** — aliases and shell functions. Service management (PostgreSQL 15, MySQL, Redis), Rails shortcuts, macOS utilities.
- **`gitconfig`** — Git identity (Cristobal Dominguez), aliases, diff/merge tools (Kaleidoscope, SourceTree).
- **`install.sh`** — orchestrates the full setup sequence.

## Architecture notes

- **No Stow or symlinks** — copy-based deployment means diffs between repo and `~` can silently drift.
- **`zshrc` sources `~/.shortcuts` and `~/.zsh_customization`** — both are in the repo and copied to `$HOME` by `install.sh`.
- **RVM** — instalado por `install.sh` vía `curl -sSL https://get.rvm.io | bash -s stable`. Instala Ruby 3.3 con `openssl@3`. `zsh_rvm` agrega RVM al PATH en cada sesión de shell.
- **Node via fnm** — `install.sh` installs Node LTS at setup time. `zshrc` initializes fnm on every shell start.
- **git-crypt** — `gitattributes` has git-crypt filters configured. Any file marked with the `crypt` attribute will be encrypted; ensure git-crypt is unlocked before working with those files.

## Tap dependency

The Brewfile uses a custom tap:

```
tap "gentleman-programming/homebrew-tap"
```

This tap provides `gentle-ai` and `codexbar`. If the tap is unavailable, `brew bundle` will fail for those packages.
