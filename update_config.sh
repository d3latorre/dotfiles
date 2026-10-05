#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(nvim zsh)

if ! command -v stow >/dev/null 2>&1; then
    echo "Error: stow is not installed." >&2
    exit 1
fi

if [[ ! -d "$HOME/.config" ]]; then
    echo "Warning: $HOME/.config does not exist, stow will create it." >&2
fi

for pkg in "${PACKAGES[@]}"; do
    if [[ ! -d "$DOTFILES/$pkg" ]]; then
        echo "Error: package '$pkg' not found in $DOTFILES" >&2
        exit 1
    fi
done

echo "Restowing dotfiles..."

stow --restow --no-folding --dir="$DOTFILES" --target="$HOME" "${PACKAGES[@]}"

echo "Restowed: ${PACKAGES[*]}"