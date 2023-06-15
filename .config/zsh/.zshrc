# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.local/share/zsh/plugins/zsh-z/zsh-z.plugin.zsh

. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# Basic auto/tab complete
autoload -Uz compinit
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

# use not vim keybindings
bindkey -e

bindkey "^[[3~" delete-char

# CTRL-R to search through history
# bindkey '^R' history-incremental-search-backward

# aliases
alias sudo='nocorrect sudo -E '
alias ls="exa -l --color=auto --sort=type --icons"
alias la="exa -al --color=auto --sort=type --icons"
alias lt="exa -al --color=auto --sort=type --icons --tree --level=3"
alias mailspring="mailspring"
alias rs="nohup redshift -l 51.28:11.58 &"
alias sd="shutdown now"
alias colorscheme='. colorscheme'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias eww='~/dev/eww/target/release/eww'

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Reduce delay for key combinations in order to change to vi mode faster
# See: http://www.johnhawthorn.com/2012/09/vi-escape-delays/
# Set it to 10ms
export KEYTIMEOUT=20

# fzf completions and keybindings for zsh
if type fzf &> /dev/null && type rg &> /dev/null; then
  export FZF_DEFAULT_OPTS='
    --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
    --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'
  export FZF_DEFAULT_COMMAND='rg --files --hidden --no-follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_CTRL_T_COMMAND='rg --files --hidden --no-follow --glob "!.git/*" --glob "!vendor/*"'
  # export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh


# xterm title for zsh from arch wiki
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
