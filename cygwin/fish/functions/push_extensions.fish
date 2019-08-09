function push_extensions
    rm -r /cygdrive/d/gallk/work/Utils/shell-extensions/cygwin/fish
    cp -r ~/.config/fish /cygdrive/d/gallk/work/Utils/shell-extensions/cygwin
    rm /cygdrive/d/gallk/work/Utils/shell-extensions/cygwin/fish/*.x86_64
    rm /cygdrive/d/gallk/work/Utils/shell-extensions/cygwin/fish/fish_variables
end
