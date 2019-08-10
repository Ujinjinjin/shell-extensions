# Public
function unity_build
    # Private functions
    function unity_build_help
        echo ""
        echo "Usage: unity_build [arguments] [flags]      Build game with specific arguments"
        echo "   or: unity_build -t win64 -c              Clean target directory and build game for win86 platform"
        echo ""
        echo "Arguments:"
        echo "    -p   or  --platform                    Target platform to build the game"
        echo "    -l   or  --license                     Path to Unity license file"
        echo "    -d   or  --buildDirectory              Build staging directory"
        echo ""
        echo "Flags:"
        echo "    -c   or  --cleanDir                    Clean target directory before building the game"
        echo "    -h   or  --help                        Print help"
        echo ""
    end

    # init arguments
    set license "~/Unity_v2019.2.0f1.alf"
    set platform "win86"
    set platformArgName "-buildWindowsPlayer"
    set buildDirectory ""
    set customDirectory false
    set validCall true
    set showHelp false
    set exceptionMessage ""

    # init flags

    # Parsing args and flags
    set n (count $argv)

    if test $n -gt 0
        set i 1
        while true
            switch $argv[$i]
                # Parsing args
                # Target platform
                case "--platform"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set platform $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                case "-t"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set platform $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                
                # Manual license file
                case "--license"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set license $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                case "-l"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set license $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                
                # Directory
                case "--buildDirectory"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set buildDirectory $argv[$i]
                        set customDirectory true
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                case "-d"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set buildDirectory $argv[$i]
                        set customDirectory true
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                
                # Parsing flags
                # Clean directory
                case "--cleanDir"
                    set cleanDir true
                case "-c"
                    set cleanDir true
                case "--help"
                    set validCall false
                    set showHelp true
                case "-h"
                    set validCall false
                    set showHelp true
                
                # Default
                case "*"
                    set validCall false
                    set exceptionMessage "ERROR: Invalid argument name:" $argv[$i]
                    break
            end
            set i (math "$i + 1")

            if test $i -gt $n
                break
            end
        end 
    end

    # Set variables
    if $customDirectory
        set buildDirectory $buildDirectory
    else
        set buildDirectory "bin/$platform"
    end

    switch $platform
        case "win86"
            set platformArgName "-buildWindowsPlayer"
        case "win64"
            set platformArgName "-buildWindows64Player"
        case "linux32"
            set platformArgName "-buildLinux32Player"
        case "linux64"
            set platformArgName "-buildLinux64Player"
        case "linuxAny"
            set platformArgName "-buildLinuxUniversalPlayer"
        case "*"
            set validCall false
            set exceptionMessage "ERROR: Unknown platform"
    end

    # Validate call
    if $validCall
        if $cleanDir
            echo "Cleaning directory: $buildDirectory"
            rm -r $buildDirectory
        end
        # Build game
        echo "Build started at:" (date)
        echo "Configuring license..."
        unity -quit -batchmode -license $license -logfile "$buildDirectory/build.log"
        echo "Building game..."
        unity -quit -batchmode $platformArgName "$buildDirectory/game.exe" -logfile "$buildDirectory/build.log"
        echo "Build finished at:" (date)
    else
        if $showHelp
            unity_build_help
        else
            # Raise exception
            echo $exceptionMessage
        end
    end
end
