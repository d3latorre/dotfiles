# Add custom completions dir
fpath=("$HOME/.config/zsh/completions" $fpath)
autoload -Uz compinit && compinit

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion