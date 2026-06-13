# Add custom completions dir
fpath=("$HOME/.config/zsh/completions" $fpath)
autoload -Uz compinit && compinit
