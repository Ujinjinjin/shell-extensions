function get_git_branch
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function markup_git_branch
    # define colors
    set YELLOW (tput setaf 3)
    set CYAN   (tput setaf 6)
    # define vars
    set git_branch (get_git_branch)

    if test "$git_branch" = ""
        echo -e ""
    else if test "$git_branch" = "master"
        echo -n {$YELLOW}" ("{$git_branch}"*)"
    else
        echo -n {$CYAN}" ("{$git_branch}"*)"
    end
end

function fish_prompt
    # define colors
    set BLUE     (tput setaf 7)
    set GREEN    (tput setaf 2)
    set PINK     (tput setaf 5)
    set RESET    (tput sgr0)
    # define vars
    set username (whoami)
    set dir_name (basename $PWD)
    set git_branch (markup_git_branch)

    if test "$dir_name" = "$username"
        set dir_name "~"
    end

    set PS1 {$GREEN}{$username}{$PINK}"@"{$BLUE}{$dir_name}{$git_branch}{$BLUE}":"{$RESET}"\$ "

    # print it
    echo -n {$PS1}
    set_color reset
end