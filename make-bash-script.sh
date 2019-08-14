#!/bin/bash

hasSH=$(echo $1 | awk -F '.' '{print $NF}')
file=""
if [[ $hasSH = "sh" ]]; then
    file=$1
else
    file=$PWD$1".sh"
fi

if [[ -f $file ]]; then
    read -s -n1 -p "File already exists! Overwrite? (y/n)" overwrite
    echo
    if [[ $overwrite = "y" ]]; then
        echo "Overwriting."
    elif [[ $overwrite = "n" ]]; then
        echo "Qutting."
        exit
    else
        echo "Invalid input. Quitting."
        exit
    fi
fi

touch $file
chmod +x $file

echo "#!/bin/bash" >> $file

if [[ -n $(dscl . list /Users | grep $2) ]]; then
    chown $2 $file
fi
