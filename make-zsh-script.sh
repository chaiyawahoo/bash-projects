#!/bin/zsh
forced=
file=
ext=
opts=0

if  [[ $1 = "-f" || "--forced" ]]; then
    forced=1
    opts=$((opts + 1))
else
    forced=0
fi

file=$(echo $@ | cut -d " " -f $(( 1 + opts )))
ext=$(echo $file | awk -F '.' '{print $NF}')
# words=$(echo $@ | wc - w)

if [[ $ext != "sh" ]]; then
    file=$file".sh"
fi

if [[ -f $file && forced = 0 ]]; then
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
