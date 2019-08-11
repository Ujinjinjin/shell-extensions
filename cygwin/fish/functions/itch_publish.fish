# Public
function itch_publish
    # Private functions
    function itch_publish_help
        echo ""
        echo "Usage: itch_publish [arguments] [flags]                  Publish game to itch.io"
        echo "   or: itch_publish -c win64 -g cursed-dungeon           Publish cursed-dungeon game with sources at bin/win64"
        echo "                                                             to the win64 channel. Same as standart butler command:"
        echo "                                                             butler push bin/win64 ujinjinjin/cursed-dungeon:win64"
        echo ""
        echo "Arguments:"
        echo "    -s   or  --src              Source folder where build artifacts are stored"
        echo "    -u   or  --user             Username on itch.io"
        echo "    -g   or  --game             Name ot ID of the game on itch.io"
        echo "    -c   or  --channel          Channel where game will be published"
        echo ""
        echo "Flags:"
        echo "    -r   or  --release          Adds '-release' at end of the channel name. Cannot be used with -b"
        echo "    -b   or  --beta             Adds '-beta' at end of the channel name. Cannot be used with -r"
        echo "    -h   or  --help             Print help information"
        echo ""
    end

    # init arguments
    set channel "win86"
    set user "ujinjinjin"
    set game ""
    set source ""
    set customSource false
    # Flags
    set release false
    set beta false
    set showHelp false
    # Exception helpers
    set validCall true
    set exceptionMessage ""

    # init flags

    # Parsing args and flags
    set n (count $argv)

    if test $n -gt 0
        set i 1
        while true
            switch $argv[$i]
                # Parsing args
                # Source directory
                case "--src"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set source $argv[$i]
                        set customSource true
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                case "-s"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set source $argv[$i]
                        set customSource true
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end

                # Username
                case "--user"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set user $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name: $argv[$i]."
                        break
                    end
                case "-u"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set user $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name: $argv[$i]."
                        break
                    end

                # Game
                case "--game"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set game $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name: $argv[$i]."
                        break
                    end
                case "-g"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set game $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name: $argv[$i]."
                        break
                    end

                # channel
                case "--channel"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set channel $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name: $argv[$i]."
                        break
                    end
                case "-c"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set channel $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name: $argv[$i]."
                        break
                    end

                # Parsing flags
                # Help
                case "--help"
                    set validCall false
                    set showHelp true
                case "-h"
                    set validCall false
                    set showHelp true
                case "--release"
                    set release true
                case "-r"
                    set release true
                case "--beta"
                    set beta true
                case "-b"
                    set beta true

                # Default
                case "*"
                    set validCall false
                    set exceptionMessage "ERROR: Invalid argument name: $argv[$i]."
                    break
            end
            set i (math "$i + 1")

            if test $i -gt $n
                break
            end
        end
    end

    # Validate input
    if $release && $beta
        set validCall false
        set exceptionMessage "ERROR: Channel cannot be both release and beta!"
    end

    if test (string length $game) -eq 0
        set validCall false
        set exceptionMessage "ERROR: You must specify game's name."
    end

    # Set variables
    if $customSource
        set source $source
    else
        set source "bin/$channel"
    end

    if $release
        set channel "$channel-release"
    end

    if $beta
        set channel "$channel-beta"
    end

    # Validate call
    if $validCall
        # Publish game
        echo "Publishing started at:" (date)
        butler push $source "$user/$game:$channel"
        echo "Publishing finished at:" (date)
    else
        if $showHelp
            itch_publish_help
        else
            # Raise exception
            echo "$exceptionMessage Use itch_publish -h for more information"
        end
    end
end
