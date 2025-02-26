#!/bin/bash

# URL to the hamster dance music
MUSIC_URL="https://archive.org/download/hampster_dance_remix/hampsterdancetechnomix.mp3"

# Start music if possible
if command -v mpv &> /dev/null; then
    mpv --no-video --volume=100 "$MUSIC_URL" --loop &>/dev/null &
elif command -v ffplay &> /dev/null; then
    ffplay -nodisp -autoexit -loop 0 "$MUSIC_URL" &>/dev/null &
else
    echo "No music player found (install 'mpv' or 'ffplay'). Continuing without music."
fi

# Cleanup on exit
trap "tput cnorm; pkill -f hampsterdancetechnomix.mp3; echo; exit" SIGINT

tput civis  # Hide cursor

# Hamster ASCII frames (equal length for consistency)
frames=(
"( $(printf '･')ω$(printf '･') ) 🐹 "
"( $(printf '･')ω$(printf '`') ) 🐹 "
"( $(printf '`')ω$(printf '･') ) 🐹 "
"( $(printf '･')ω$(printf '`') ) 🐹 "
)

# Hamster dance lyrics
lyrics=(
"Dee dee dee dee dee do do"
"Ha ha ha ha ha ha!"
"Doo doo doo doo doo"
"Lalala la la la la"
"Whoa oh oh oh oh"
)

# Function to calculate display width of a string
display_width() {
    local str="$1"
    echo -n "$str" | wc -m
}

# Function to print a row of hamsters across the terminal
print_hamster_row() {
    local frame_index="$1"
    local cols
    cols=$(tput cols)

    local hamster="${frames[$frame_index]}"
    local hamster_len
    hamster_len=$(display_width "$hamster")

    [[ -z "$hamster_len" || "$hamster_len" -le 0 ]] && hamster_len=12

    local repeat=$((cols / hamster_len))
    local line=""

    for ((i=0; i<repeat; i++)); do
        line+="$hamster"
    done

    printf "%.*s\n" "$cols" "$line"  # Truncate line to fit terminal width
}

clear

# Print static header
echo -e "\n🎶 🐹 WELCOME TO THE HAMSTER DANCE 🐹 🎶"
echo -e "\n$(shuf -n 1 -e "${lyrics[@]}") 🎵\n"

# Calculate available rows for dancing
rows=$(( $(tput lines) - 6 ))
[[ "$rows" -lt 1 ]] && rows=1  # Ensure at least one row

# Animation loop with multiple rows of dancing hamsters
while true; do
    for frame_index in "${!frames[@]}"; do
        tput cup 4 0  # Move cursor below header
        for ((row=0; row<rows; row++)); do
            print_hamster_row "$frame_index"
        done
        sleep 0.15
    done
done
