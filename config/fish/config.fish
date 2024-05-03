starship init fish | source
set fish_greeting
bind \cf '. ~/dotfiles/fzf.fish'

#pkill gpg-agent
#gpg-agent --pinentry-program=/usr/bin/pinentry --daemon > /dev/null 2>&1
set -x SSH_AUTH_SOCK $(gpgconf --list-dirs agent-ssh-socket)

set -x PATH "$HOME/.local/bin:$HOME/bin:$PATH"

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias l='ls -CF'
alias vim='nvim'
alias vi='nvim'

# options that eza, exa and ls accept
set -l shared_opts -F --sort extension

# exa's -a is -A in practice so it doesnt support -A. eza correctly
# understands them as being the same. since ls is still ls,
# we use -A unless its exa, then we use -a :rolling_eyes:
set -l show_all_opt -A

set -l exaopts -n --no-user --group-directories-first --git --icons
set -l ezaopts -Mo --hyperlink --git-repos-no-status --color-scale=size

set -l opts $shared_opts

if set ls_impl $(command -v eza)
    set exa_available

    set -a opts $exaopts $ezaopts
else if set ls_impl $(command -v exa)
    set exa_available
    
    set show_all_opt -a
    set -a opts $exaopts
else
    # neither exa nor eza are installed, so we stick with ls
    # 
    # -h for human readable numbers(exa/eza default)
    # --hyperlink because exa doesnt support it, cant be shared
    # --color because ls is fucking ancient
    set ls_impl ls
    set -a opts -h --hyperlink=auto --color=auto
end

alias 'ls'="$ls_impl $opts"

# if exa/eza are available, we can use them as tree
if set -q exa_available
    set -e exa_available
    
    alias 'gls'='ls -l --git-ignore'
    alias 'tree'='ls --tree'
    alias 'ltree'='tree -l'
    alias 'gtree'='tree -l --git-ignore'
end

alias 'l'='ls -l'
alias 'll'='l'
alias 'la'="ll $show_all_opt"

zoxide init --cmd cd fish | source

