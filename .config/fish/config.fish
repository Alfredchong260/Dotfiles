set fish_greeting                   # No welcome message during enter fish shell
colorscript random                  # Random colorscript when enter fish shell
starship init fish | source         # Start starship
set TERM "xterm-256color"           # Set terminal type

# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

function Get_Qtile
    sed -n '/START_KEYS/,/END_KEYS/p' ~/.config/qtile/config.py | \
    grep -v '#' | \
    grep 'Key' | \
    sed -e 's/^[ \t]*//'
end

# v function can easily get into file
function v -a change
    set ori_dir (pwd)
    cd $HOME
    set file (fd -Hai . | fzf)

    if test -z $file
        return 1
    end

    set split (string split / $file)
    set chdir "$split[1..-2]"

    if test -z $change
        cd $ori_dir
    else
        set dir (string replace -a ' ' / $chdir)
        cd $dir

        set has_git (fd -Ha . ../ | rg "git\$")
        set len_of_has_git (count $has_git)

        if test $len_of_has_git -eq 1
           cd $has_git
           cd ..
        end
    end
    nvim $file
end

function ll
    ls -lh $argv
end

# change wallpaper
function change
    nitrogen --random --set-tiled
end

# run neovide in root
function vid
    neovide $argv
end

# run neovide
function vide
    sudo neovide $argv
end

# run neovim
function vi
    nvim $argv
end

# run neovim in root
function vim
    sudo nvim $argv
end

# update all packages
function update
    sudo pacman -Syyuu
end

# git push in one line of command 
function Git
    git add .
    git commit -m $argv
    git push origin main
end

# straghitly get into init.lua file
function edit
    cd  ~/.config/nvim
    nvim init.lua
end

set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan


# change the shell in a easy way
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"


# setup the environment
set PATH $PATH /usr/local/bin
set -gx PATH $PATH /usr/local/lib/nodejs/node-v14.17.4-linux-x64/bin/
set -gx PATH $PATH $HOME/.cargo/bin/
set -gx PATH $PATH $HOME/.cargo/bin/
export PATH
