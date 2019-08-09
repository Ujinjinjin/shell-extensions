# Public
function build_game
    # Private functions
    function build_game_help
        echo ""
        echo "Usage: build_game [arguments] [flags]      Build game with specific arguments"
        echo "   or: build_game -t win64 -c              Clean target directory and build game for win86 platform"
        echo ""
        echo "Arguments:"
        echo "    -t   or  --targetPlatform              Target platform to build the game"
        echo "    -ml  or  --manualLicenseFile           Path to Unity license file"
        echo "    -d   or  --buildDirectory              Build staging directory"
        echo ""
        echo "Flags:"
        echo "    -c   or  --cleanDir                    Clean target directory before building the game"
        echo "    -h   or  --help                        Print help"
        echo ""
    end

    # init arguments
    set manualLicenseFile "~/Unity_v2019.2.0f1.alf"
    set targetPlatform "win86"
    set targetPlatformArgName "-buildWindowsPlayer"
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
                case "--targetPlatform"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set targetPlatform $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                case "-t"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set targetPlatform $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                
                # Manual license file
                case "--manualLicenseFile"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set manualLicenseFile $argv[$i]
                    else
                        set i (math "$i - 1")
                        set validCall false
                        set exceptionMessage "ERROR: Empty value error! Argument name:" $argv[$i]
                        break
                    end
                case "-ml"
                    set i (math "$i + 1")
                    if test (string length $argv[$i]) -gt 0
                        set manualLicenseFile $argv[$i]
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
        set buildDirectory "bin/$targetPlatform"
    end

    switch $targetPlatform
        case "win86"
            set targetPlatformArgName "-buildWindowsPlayer"
        case "win64"
            set targetPlatformArgName "-buildWindows64Player"
        case "linux32"
            set targetPlatformArgName "-buildLinux32Player"
        case "linux64"
            set targetPlatformArgName "-buildLinux64Player"
        case "linuxAny"
            set targetPlatformArgName "-buildLinuxUniversalPlayer"
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
        unity -quit -batchmode -manualLicenseFile $manualLicenseFile -logfile "$buildDirectory/build.log"
        echo "Building game..."
        unity -quit -batchmode $targetPlatformArgName "$buildDirectory/game.exe" -logfile "$buildDirectory/build.log"
        echo "Build finished at:" (date)
    else
        if $showHelp
            build_game_help
        else
            # Raise exception
            echo $exceptionMessage
        end
    end
end
