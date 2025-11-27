# Installing DevOS

DevOS is distributed as a single binary with no dependencies. Choose your preferred installation method below.

## Quick Install (Recommended)

**Linux and macOS:**
```bash
curl -fsSL https://raw.githubusercontent.com/devos-project/devos/latest/install.sh | sh
```

The install script will:
- Detect your operating system and architecture
- Download the appropriate binary
- Install to `/usr/local/bin` (or `~/.local/bin` if not writable)
- Verify the installation

## Manual Installation

### 1. Download Binary

Download the binary for your platform from the [latest release](https://github.com/devos-project/devos/releases/latest):

**Linux:**
- AMD64: `devos-linux-amd64`
- ARM64: `devos-linux-arm64`

**macOS:**
- Intel (AMD64): `devos-darwin-amd64`
- Apple Silicon (ARM64): `devos-darwin-arm64`

### 2. Install Binary

```bash
# Make the binary executable
chmod +x devos-*

# Move to a directory in your PATH
sudo mv devos-* /usr/local/bin/devos

# Or install to user directory
mkdir -p ~/.local/bin
mv devos-* ~/.local/bin/devos
export PATH="$PATH:$HOME/.local/bin"  # Add to ~/.bashrc or ~/.zshrc
```

### 3. Verify Installation

```bash
devos version
```

You should see output like:
```
DevOS Dev-Tools version v2.17.0
```

## Next Steps

- Run `devos --help` to see available commands
- Check for updates: `devos version --check`
- See [UPDATE.md](UPDATE.md) for update instructions

## Troubleshooting

**Binary not found after installation:**
- Ensure the installation directory is in your PATH
- For `~/.local/bin`, add to your shell profile: `export PATH="$PATH:$HOME/.local/bin"`

**Permission denied:**
- Make sure the binary is executable: `chmod +x /path/to/devos`
- Or use sudo for system-wide installation: `sudo mv devos /usr/local/bin/`

**macOS security warning:**
- Right-click the binary and select "Open" to bypass Gatekeeper
- Or run: `xattr -d com.apple.quarantine /usr/local/bin/devos`
