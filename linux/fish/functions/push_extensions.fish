function push_extensions
    rm -f -r /mnt/d/gallk/work/Utils/shell-extensions/linux/fish
    cp -r ~/.config/fish /mnt/d/gallk/work/Utils/shell-extensions/linux
    rm -f '/mnt/d/gallk/work/Utils/shell-extensions/linux/fish/fishd.*'
    rm -f '/mnt/d/gallk/work/Utils/shell-extensions/linux/fish/fish_variables'
end