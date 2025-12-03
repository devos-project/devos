# Installing dt

## Quick Install (Recommended)

Run the installation script:

```bash
curl -fsSL https://raw.githubusercontent.com/devos-project/dt/latest/install.sh | sh
```

The script automatically:
- Detects your OS and architecture
- Downloads the correct binary
- Verifies checksums
- Installs to `/usr/local/bin` (or `~/.local/bin` if not writable)

## Manual Installation

Download the binary for your platform from the [latest release](https://github.com/devos-project/dt/releases/latest):

### Linux
- AMD64: `dt-linux-amd64`
- ARM64: `dt-linux-arm64`

### macOS
- Intel (AMD64): `dt-darwin-amd64`
- Apple Silicon (ARM64): `dt-darwin-arm64`

### Steps

1. **Download the binary** for your platform

2. **Make it executable**
```bash
chmod +x dt-*
```

3. **Move to a directory in your PATH**
```bash
# System-wide (requires sudo)
sudo mv dt-* /usr/local/bin/dt
```

Or for user-only installation:
```bash
# Create ~/.local/bin if it doesn't exist
mkdir -p ~/.local/bin

# Move binary
mv dt-* ~/.local/bin/dt
chmod +x ~/.local/bin/dt

# Add to PATH (add to ~/.bashrc or ~/.zshrc)
export PATH="$PATH:$HOME/.local/bin"
```

4. **Verify installation**
```bash
dt version
```

## Verifying Checksums

Each release includes a checksums file. To verify your download:

```bash
# Download checksums file
curl -LO https://github.com/devos-project/dt/releases/latest/download/dt-v3.0.0-checksums.txt

# Verify (Linux)
sha256sum -c dt-v3.0.0-checksums.txt --ignore-missing

# Verify (macOS)
shasum -a 256 -c dt-v3.0.0-checksums.txt --ignore-missing
```

## Post-Installation

After installation, verify dt is working:

```bash
dt --help
```

Check for updates:
```bash
dt version --check
```

## Troubleshooting

### "Permission denied"
```bash
chmod +x /path/to/dt
```

### "command not found"
Ensure the binary is in your PATH:
```bash
sudo mv dt /usr/local/bin/
```

### macOS Gatekeeper Warning
If macOS blocks the binary, run:
```bash
xattr -d com.apple.quarantine /usr/local/bin/dt
```
