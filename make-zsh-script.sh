#!/bin/zsh
forced=0
file=
ext=
opts=0

if  [[ $1 = "-f" || $1 = "--forced" ]]; then
    forced=1
    ((opts++))
fi

file=$(echo $@ | cut -d " " -f $(( 1 + opts )))
ext=$(echo $file | awk -F '.' '{print $NF}')

if [[ -z $file ]]; then
    echo "Must supply file name!"
    exit 1
fi

if [[ $ext != "sh" ]]; then
    file=$file".sh"
fi

echo $forced

if [[ -f $file && $forced = 0 ]]; then
    read -q "?File already exists! Overwrite? (y/n)" overwrite
    echo
    if [[ $overwrite = "y" ]]; then
        echo "Overwriting."
    elif [[ $overwrite = "n" ]]; then
        echo "Qutting."
        exit 0
    else
        echo "Invalid input '$overwrite'. Quitting." >&2
        exit 1
    fi
fi

echo "#!/bin/zsh" > $file
chmod +x $file
