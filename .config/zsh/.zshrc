# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/plugins/zsh-z/zsh-z.plugin.zsh


# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# include hidden files

# History settings
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.

# completion settings
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt auto_pushd
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# use vim keybindings
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

bindkey "^[[3~" delete-char
# CTRL-R to search through history
# bindkey '^R' history-incremental-search-backward

# aliases
alias ssh='TERM=xterm-256color ssh' # verhindert: unknown terminal alacritty
alias sudo='nocorrect sudo -E '
alias ls="exa -l --color=auto --sort=type --icons"
alias la="exa -al --color=auto --sort=type --icons"
alias lt="exa -al --color=auto --sort=type --icons --tree --level=3"
alias mailspring="mailspring"
alias rs="nohup redshift -l 51.28:11.58 &"
alias sd="shutdown now"
alias colorscheme='. colorscheme'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Reduce delay for key combinations in order to change to vi mode faster
# See: http://www.johnhawthorn.com/2012/09/vi-escape-delays/
# Set it to 10ms
export KEYTIMEOUT=20

colors=$(tail -n 1 /home/eike/.config/alacritty/alacritty.yml)
# fzf completions and keybindings for zsh
if type fzf &> /dev/null && type rg &> /dev/null; then
    if [[ $(tail -n 1 /home/eike/.config/alacritty/alacritty.yml) == "#light" ]]; then
    export FZF_DEFAULT_OPTS='
      --color fg:#3c3836,bg:#f9f5d7,hl:#b57614:,fg+:#3c3836,bg+:#f2edcb,hl+:#b57614
      --color info:#076678,prompt:#665c54,spinner:#b57614,pointer:#076678,marker:#af3a03,header:#bdae93'
    alias cat='bat --theme=gruvbox-light'
  else 
    export FZF_DEFAULT_OPTS='
      --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
      --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'
    alias cat='bat --theme=gruvbox-dark'
  fi
  export FZF_DEFAULT_COMMAND='rg --files --hidden --no-follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_CTRL_T_COMMAND='rg --files --hidden --no-follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# source "$HOME/.rvm/scripts/rvm"
