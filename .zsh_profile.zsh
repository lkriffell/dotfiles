# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{cyan}%d $(git_branch_color)${vcs_info_msg_0_} %f
🪐  '
eval "$(rbenv init -)"

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

# Determine if current working directory is a git repository
git_branch_color() {
  if current_git_status=$(git status 2> /dev/null); then
    parse_git_dirty
  else
    echo ""
  fi
}

# Change branch color if working tree is clean
parse_git_dirty() {
  if current_git_status=$(git status | grep 'Changes to be committed:\|Untracked files:\|modified:|deleted:' 2> /dev/null); then
    echo "%F{red}"
  else
    echo "%F{green}"
  fi
}

# added by travis gem
[ ! -s /Users/loganriffell/.travis/travis.sh ] || source /Users/loganriffell/.travis/travis.sh


. $HOME/.asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Aliases
alias be="bundle exec"
alias gc="git checkout"
alias zsh="atom . ~/.zshrc"
alias glog='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
