function mk
    if test (count $argv) -eq 1
        mkdir $argv[1]; and cd $argv[1]
    else
        echo "Usage: mk <directory>"
    end
end
