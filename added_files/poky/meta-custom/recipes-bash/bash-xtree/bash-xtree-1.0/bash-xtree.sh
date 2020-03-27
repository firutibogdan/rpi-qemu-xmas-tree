#!/usr/bin/env sh

# input file
input="/tree.txt"
first=1

while true; do

    # check if file exists
    if test -f "$input"; then

        # don't flush at first
        if [[ "$first" -eq "1" ]]; then
            first=0
        else
            sleep 1
        fi

        tput clear

        # read line by line the file
        while IFS= read -r line
        do
            # default color for a line is null
            line_color=0

            # for each character
            for i in $(seq 0 $((${#line} - 1))); do

                # try to set character color
                char_color=0

                if [[ "${line:$i:1}" == "|" ]]; then
                    # brown for "|"
                    line_color=52
                    char_color=52

                elif [[ "${line:$i:1}" == "/" ]] || [[ "${line:$i:1}" == "\\" ]]; then
                    # green for "/\"
                    line_color=22
                    char_color=22

                elif [[ "${line:$i:1}" == "^" ]]; then
                    # yellow for "^"
                    line_color=11
                    char_color=11

                elif [[ "${line:$i:1}" == "~" ]]; then
                    # red for "~"
                    char_color=9

                elif [[ "${line:$i:1}" == "\`" ]]; then
                    # blue for "`"
                    char_color=27

                elif [[ "${line:$i:1}" == "*" ]]; then
                    # magenta for "*"
                    char_color=13

                elif [[ "${line:$i:1}" == "&" ]]; then
                    # white for "&"
                    char_color=15

                elif [[ "${line:$i:1}" == "+" ]]; then
                    # cyan for "+"
                    char_color=6

                else
                    # default color is the one established
                    char_color=$line_color

                fi

                printf "\e[48;5;%sm \e[0m" "$char_color" # print color

            done
            echo
        done < "$input"
    fi
done

