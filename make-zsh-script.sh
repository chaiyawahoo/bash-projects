#!/bin/zsh
forced=false
file=$(echo $@ | cut -d ' ' -f $# 2>/dev/null)
ext=$(echo $file | awk -F '.' '{print $NF}')

if [[ $# > 1 ]]; then
    for option in $(printf '%s\n' $@ | sed -n '/^-/p'); do
        if  [[ $option = '-f' || $option = '--forced' ]]; then
            forced=true
        else
            echo $option 'is not an option!' >&2
            exit 1
        fi
    done
fi

if [[ -z $file ]]; then
    echo 'Must supply file name!' >&2
    exit 1
fi

if [[ $ext != 'sh' ]]; then
    file=$file'.sh'
fi

if [[ -f $file && $forced = false ]]; then
    read -q -s '?File already exists! Overwrite? (y/n)' overwrite
    echo
    if [[ $overwrite = 'y' ]]; then
        echo 'Overwriting.'
    else
        echo 'Quitting.'
        exit 0
    fi
fi

echo '#!/bin/zsh' > $file
chmod +x $file
