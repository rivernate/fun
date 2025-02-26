#!/bin/bash
# Ultra-Optimized Matrix Digital Rain in Bash with Density Option
# Usage: ./matrix_density.sh [density]
#   density: integer from 1 to 100 (default is 80)
#
# A higher density means more columns update per frame. Note that very high
# densities (e.g. 100) may slow down the animation on some terminals.

# Hide the cursor and ensure it’s restored on exit.
tput civis
trap "tput cnorm; echo -ne '\033[0m'; clear; exit" SIGINT SIGTERM

# Get density from command-line parameter (default to 80 if not provided).
density=${1:-80}
if ! [[ $density =~ ^[0-9]+$ ]] || (( density < 1 || density > 100 )); then
  echo "Density must be an integer between 1 and 100."
  exit 1
fi

# ANSI color codes for the head and tail.
head_color="\033[1;37m"    # Bright white for the head.
tail_color1="\033[1;32m"   # Bright green for the first tail character.
tail_color2="\033[0;32m"   # Dim green for the rest of the tail.
reset_color="\033[0m"

# Get terminal dimensions.
rows=$(tput lines)
cols=$(tput cols)

# Character set for the rain.
charset='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()-_=+[]{}|;:,.<>/?'

# Arrays to store drop head positions and tail lengths for each column.
declare -a drops
declare -a tails

# Initialize each column's drop starting position and tail length.
for (( i=0; i<cols; i++ )); do
    drops[i]=$(( RANDOM % rows - rows ))
    tails[i]=$(( RANDOM % 10 + 15 ))
done

# Main loop: update only a subset of columns based on the density parameter.
while true; do
    output=""
    for (( i=0; i<cols; i++ )); do
        # Only update this column if a random chance (0-99) is less than the density.
        if (( RANDOM % 100 >= density )); then
            continue
        fi

        head=${drops[i]}
        tail_len=${tails[i]}

        # Clear the cell that just left the tail.
        clear_row=$(( head - tail_len ))
        if (( clear_row >= 0 && clear_row < rows )); then
            output+="\033[${clear_row};${i}H "  # Move cursor and print a space.
        fi

        # Draw the drop: head and its tail.
        for (( j=0; j<tail_len; j++ )); do
            row=$(( head - j ))
            if (( row >= 0 && row < rows )); then
                if (( j == 0 )); then
                    color=$head_color
                elif (( j == 1 )); then
                    color=$tail_color1
                else
                    color=$tail_color2
                fi
                # Pick a random character.
                char=${charset:$(( RANDOM % ${#charset} )):1}
                output+="\033[${row};${i}H${color}${char}${reset_color}"
            fi
        done

        # Advance the drop.
        drops[i]=$(( head + 1 ))
        # Reset the drop if its tail has completely left the screen.
        if (( drops[i] - tail_len > rows )); then
            drops[i]=$(( RANDOM % rows - rows ))
            tails[i]=$(( RANDOM % 10 + 5 ))
        fi
    done

    # Output the batched changes in one go.
    echo -ne "$output"
    sleep 0.05
done

