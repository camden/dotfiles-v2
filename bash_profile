source ~/.git-completion.bash

alias ls='ls -aFG'
alias vim='mvim -v'

alias vsfindnopreview="rg . --line-number --no-heading -t js | fzf --delimiter=: --nth 3.. | sed 's/\([^:]*:[^:]*\):.*$/\1/' | xargs code -g"

general_vsfind () {
  local filetype_string=$1

  rg '^\s*(.*)$' --replace '$1' \
  --line-number --no-heading $filetype_string \
  | fzf -m \
  --delimiter=: \
  --with-nth 3.. \
  --preview "echo {} | sed 's/\([^:]*\):[^:]*:.*$/\1/'" \
  --preview-window down:1 \
  | sed 's/\([^:]*:[^:]*\):.*$/\1/' \
  | xargs code -g
}

vsfind () {
  general_vsfind "-t js"
}

vsfindall () {
  general_vsfind
}


# git stuff
alias gc='git commit'
alias gca='git commit -av'
alias gco='git checkout'
__git_complete gco _git_checkout
alias gd='git diff'
alias gp='git push'
__git_complete gp _git_push
alias gs='git status'

# smart case by default for ripgrep
alias rg="rg --smart-case"

# vi mode
set -o vi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# from https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
# --files: List files that would be searched but do not search
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND=${FZF_DEFAULT_COMMAND}

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

PATH=$PATH:~/.local/bin

source ~/.prompt
