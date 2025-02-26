# Terminal Fun Scripts 🎮

A collection of fun and entertaining terminal-based animations written in Bash.

## Scripts

### 🐹 Hamster Dance (`hamster_dance.sh`)

An animated ASCII hamster dance with music! Watch cute hamsters dance across your terminal while the classic Hamster Dance song plays in the background.

**Features:**
- Animated ASCII hamsters
- Classic Hamster Dance music (requires `mpv` or `ffplay`)
- Auto-adjusts to terminal size
- Includes dancing lyrics

**Requirements:**
- For music: either `mpv` or `ffplay` installed
- Bash shell
- Unicode terminal support for emojis

**Usage:**
```bash
./hamster_dance.sh
```

Press `Ctrl+C` to exit.

### 🌧️ Matrix Digital Rain (`matrix.sh`)

A customizable implementation of the iconic Matrix digital rain effect in your terminal.

**Features:**
- Customizable rain density
- Dynamic character set
- Color gradients (bright white heads, bright green first character, dim green tail)
- Auto-adjusts to terminal size
- Optimized performance

**Usage:**
```bash
./matrix.sh [density]
```

- `density`: Optional parameter (1-100, default: 80) to control how dense the rain appears
  - Higher values = more columns update per frame
  - Lower values = sparser rain effect

Press `Ctrl+C` to exit.

## Installation

1. Clone this repository:
```bash
git clone [repository-url]
```

2. Make the scripts executable:
```bash
chmod +x hamster_dance.sh matrix.sh
```

3. Run either script as shown in the usage instructions above.

## Requirements

- Bash shell
- Unicode-capable terminal
- For Hamster Dance music: `mpv` or `ffplay`

## License

Feel free to use and modify these scripts for your entertainment!

## Contributing

Contributions are welcome! Feel free to submit pull requests with new animations or improvements to existing ones.