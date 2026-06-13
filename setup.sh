#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
info() { echo "[setup] $*"; }

# ── package manager ──────────────────────────────────────────────────────────
if   command -v apt-get &>/dev/null; then PM=apt
elif command -v dnf     &>/dev/null; then PM=dnf
elif command -v pacman  &>/dev/null; then PM=pacman
elif command -v brew    &>/dev/null; then PM=brew
else echo "No supported package manager found." >&2; exit 1
fi

pkg() {
    case "$PM" in
        apt)    sudo apt-get install -y "$@" ;;
        dnf)    sudo dnf install -y "$@" ;;
        pacman) sudo pacman -S --noconfirm "$@" ;;
        brew)   brew install "$@" ;;
    esac
}

info "Updating package lists..."
case "$PM" in
    apt)    sudo apt-get update -qq ;;
    pacman) sudo pacman -Sy --noconfirm ;;
    brew)   brew update ;;
esac

# ── core ─────────────────────────────────────────────────────────────────────
info "Installing core packages..."
pkg git zsh curl stow

# ── zsh as default shell ─────────────────────────────────────────────────────
ZSH_PATH="$(command -v zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
    info "Setting zsh as default shell..."
    chsh -s "$ZSH_PATH"
fi

# ── oh-my-zsh ────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing oh-my-zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ── pyenv ────────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.pyenv" ]; then
    info "Installing pyenv..."
    curl -fsSL https://pyenv.run | bash
fi

# ── neovim ───────────────────────────────────────────────────────────────────
NVIM_VERSION="v0.12.3"

if ! command -v nvim &>/dev/null; then
    info "Installing neovim ${NVIM_VERSION}..."
    ARCH="$(uname -m)"
    case "$ARCH" in
        x86_64)        NVIM_ARCH="x86_64" ;;
        aarch64|arm64) NVIM_ARCH="arm64"  ;;
        *) echo "Unsupported arch: $ARCH" >&2; exit 1 ;;
    esac
    curl -L "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz" \
        | sudo tar -C /opt -xz
    sudo ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
fi

# ── stow dotfiles ────────────────────────────────────────────────────────────
info "Stowing dotfiles..."

# Remove files/dirs that stow doesn't own — oh-my-zsh creates ~/.zshrc on install
for conflict in "$HOME/.zshrc"; do
    [ -e "$conflict" ] || [ -L "$conflict" ] && rm -f "$conflict"
done

stow --dir="$DOTFILES_DIR" --target="$HOME" --restow zsh

# ~/.config/nvim may exist as a real dir (e.g. from a previous manual install)
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    info "Backing up existing ~/.config/nvim to ~/.config/nvim.bak"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi

stow --dir="$DOTFILES_DIR" --target="$HOME" --restow nvim

info "Done. Restart shell or run: exec zsh"
