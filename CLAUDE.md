# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

This is NOT an app, NOT a website, NOT a library. It's a personal Mac setup repository — a collection of configuration files and installation scripts that define exactly how Cristobal's Mac should be configured from scratch.

The purpose is simple: whenever a Mac needs to be set up (new machine, reinstall, reset), clone this repo from GitHub and run one script. Everything installs and configures itself in the right order, automatically.

**This repo lives on GitHub and is used as a restore point.** Changes made here represent intentional, permanent decisions about the development environment.

## Entry point: `install.sh`

This is THE file that matters. Everything starts here. The installation sequence is:

1. **Rosetta** (`01_rosetta.sh`) — installs on Apple Silicon (ARM64) machines
2. **Xcode CLI tools** (`02_xcode.sh`) — required by everything else
3. **Dotfiles** (`03_dotfiles.sh`) — copies config files from `dotfiles/` to `$HOME`, creates `~/.zsh.d/`
4. **Homebrew** (`04_homebrew.sh`) — with a health check before continuing
5. **Oh-My-Zsh** (`05_ohmyzsh.sh`) — fonts, Oh-My-Zsh unattended, Terminal preferences
6. **Homebrew packages** (`06_brew_packages.sh`) — runs `brew bundle --file=./Brewfile`
7. **Zsh plugins** (`07_zsh_plugins.sh`) — clones 3 plugins into Oh-My-Zsh custom plugins directory:
   - `zsh-autosuggestions`
   - `zsh-syntax-highlighting`
   - `zsh-history-substring-search`
8. **Ruby via mise** (`08_mise_ruby.sh`) — installs latest Ruby via mise (fallback: `ruby@3`), copies `gemrc`
9. **Node LTS via mise** (`09_node.sh`) — installs latest LTS via `mise use --global node@lts`, copies pnpm config
10. **Ollama** (`10_ollama.sh`) — installs via official curl installer, copies `zsh/05_ollama.zsh` with Claude Code env vars

To run on a fresh Mac:

```bash
git clone <repo-url>
cd Dotfiles
./install.sh
```

## How dotfiles are deployed

There is no symlink manager. Each installation step uses `cp` to copy files to their destinations. The mapping is:

**Deployed by `scripts/03_dotfiles.sh`:**

| Repo file | Destination |
|-----------|-------------|
| `dotfiles/zshrc` | `~/.zshrc` |
| `dotfiles/shortcuts` | `~/.shortcuts` |
| `dotfiles/zsh_customization` | `~/.zsh_customization` |
| `dotfiles/gitconfig` | `~/.gitconfig` |
| `dotfiles/gitignore` | `~/.gitignore` |
| `dotfiles/gitattributes` | `~/.gitattributes` |

**Deployed by their respective installation step:**

| Repo file | Destination | Deployed by |
|-----------|-------------|-------------|
| `dotfiles/gemrc` | `~/.gemrc` | `08_mise_ruby.sh` |
| `zsh/01_homebrew.zsh` | `~/.zsh.d/01_homebrew.zsh` | `04_homebrew.sh` |
| `zsh/02_ohmyzsh.zsh` | `~/.zsh.d/02_ohmyzsh.zsh` | `05_ohmyzsh.sh` |
| `zsh/03_brew_tools.zsh` | `~/.zsh.d/03_brew_tools.zsh` | `06_brew_packages.sh` |
| `zsh/04_pnpm.zsh` | `~/.zsh.d/04_pnpm.zsh` | `09_node.sh` |
| `zsh/05_ollama.zsh` | `~/.zsh.d/05_ollama.zsh` | `10_ollama.sh` |

After editing any of these files, the change only takes effect in the shell after re-running `install.sh` or manually copying the file to its destination.

## Modular zsh configuration (`zsh/` directory)

The `zsh/` directory contains modular shell configuration files deployed to `~/.zsh.d/`. The main `zshrc` is a thin loader that sources all `*.zsh` files from `~/.zsh.d/` in alphabetical order. Each file is owned by the installation step that installs the corresponding tool.

| File | Owned by | Contents |
|------|----------|----------|
| `zsh/01_homebrew.zsh` | `04_homebrew.sh` | `brew shellenv` — sets Homebrew PATH and env vars |
| `zsh/02_ohmyzsh.zsh` | `05_ohmyzsh.sh` | ZSH_THEME, plugins, source oh-my-zsh.sh, agnoster override |
| `zsh/03_brew_tools.zsh` | `06_brew_packages.sh` | mise, gnu-sed, fzf, bat |
| `zsh/04_pnpm.zsh` | `09_node.sh` | PNPM_HOME and PATH |
| `zsh/05_ollama.zsh` | `10_ollama.sh` | ANTHROPIC_AUTH_TOKEN, ANTHROPIC_API_KEY, ANTHROPIC_BASE_URL for Claude Code |

## Key files

- **`Brewfile`** — all Homebrew packages and casks. Add new tools here.
- **`dotfiles/zshrc`** — thin loader: sources `~/.shortcuts`, `~/.zsh_customization`, and all `~/.zsh.d/*.zsh` files.
- **`dotfiles/zsh_customization`** — history config (HISTFILE, HISTSIZE, setopts), keybindings, completion styles.
- **`dotfiles/shortcuts`** — aliases and shell functions. Service management (PostgreSQL 15, MySQL, Redis), Rails shortcuts, macOS utilities.
- **`dotfiles/gitconfig`** — Git identity (Cristobal Dominguez), aliases, diff/merge tools (Kaleidoscope, SourceTree).
- **`install.sh`** — orchestrates the full setup sequence.

## Architecture notes

- **No Stow or symlinks** — copy-based deployment means diffs between repo and `~` can silently drift.
- **`dotfiles/zshrc` sources `~/.shortcuts` and `~/.zsh_customization`** — both are in `dotfiles/` and copied to `$HOME` by `03_dotfiles.sh`.
- **Ruby via mise** — mise se instala vía Brewfile. `scripts/08_mise_ruby.sh` corre `mise use --global ruby@latest` (fallback: `ruby@3`). `zsh/03_brew_tools.zsh` inicializa mise con `eval "$(/opt/homebrew/bin/mise activate zsh)"`.
- **Node via mise** — `scripts/09_node.sh` installs Node LTS via `mise use --global node@lts`. mise is pre-installed via Brewfile.
- **git-crypt** — `gitattributes` has git-crypt filters configured. Any file marked with the `crypt` attribute will be encrypted; ensure git-crypt is unlocked before working with those files.

## Tap dependency

The Brewfile uses a custom tap:

```
tap "gentleman-programming/homebrew-tap"
```

This tap provides `gentle-ai` and `codexbar`. If the tap is unavailable, `brew bundle` will fail for those packages.
