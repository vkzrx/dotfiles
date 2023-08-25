function mkdc
    if test (count $argv) -eq 1
        mkdir $argv[1]; and cd $argv[1]
    else
        echo "Usage: mkdc <directory>"
    end
end
