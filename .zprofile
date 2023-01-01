# Profile file. Runs on login. Environmental variables are set here.
#
# Adds '~/.local/bin' to $PATH
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$HOME/.local/bin/:$HOME/Dokumente/Studium/OOP/bootcamp/"
export PATH="$PATH:$GEM_HOME/bin"

# Default programs:
export EDITOR="nvim"
export BROWSER="firefox"
export READER="zathura"

# ~/ Clean-up:
export ZDOTDIR="$HOME/.config/zsh"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
