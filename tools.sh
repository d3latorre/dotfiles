#!/usr/bin/env bash
set -euo pipefail

info() { echo "[tools] $*"; }

ask() {
    local prompt="$1"
    local answer
    read -r -p "$prompt [y/N] " answer
    [[ "${answer,,}" == "y" ]]
}

# ── containers ───────────────────────────────────────────────────────────────
if ask "Install container tools? (podman, buildah, skopeo)"; then
    info "Installing container tools..."
    sudo apt-get install -y podman buildah skopeo
fi

# ── infrastructure ───────────────────────────────────────────────────────────
if ask "Install infrastructure tools? (terraform, kubectl)"; then
    info "Installing terraform..."
    wget -O- https://apt.releases.hashicorp.com/gpg \
        | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
        | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt-get update -qq && sudo apt-get install -y terraform

    info "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
fi

# ── network tools ────────────────────────────────────────────────────────────
if ask "Install network tools? (nmap, netcat, dig, whois)"; then
    info "Installing network tools..."
    sudo apt-get install -y nmap netcat-openbsd dnsutils whois
fi

# ── node via nvm ─────────────────────────────────────────────────────────────
if ask "Install Node.js? (via nvm, installs LTS)"; then
    info "Installing nvm..."
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"
    info "Installing Node LTS..."
    nvm install --lts
fi

info "Done."
