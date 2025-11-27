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

**Option A: System-wide installation** (requires sudo)

Make the binary executable:
```bash
chmod +x devos-*
```

Move to /usr/local/bin:
```bash
sudo mv devos-* /usr/local/bin/devos
```

**Option B: User installation** (no sudo required)

Create user bin directory:
```bash
mkdir -p ~/.local/bin
```

Move the binary:
```bash
mv devos-* ~/.local/bin/devos
chmod +x ~/.local/bin/devos
```

Add to your PATH (add this to ~/.bashrc or ~/.zshrc):
```bash
export PATH="$PATH:$HOME/.local/bin"
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

Check available commands:
```bash
devos --help
```

Check for updates:
```bash
devos version --check
```

See [UPDATE.md](UPDATE.md) for update instructions.

## Troubleshooting

**Binary not found after installation:**
- Ensure the installation directory is in your PATH
- For `~/.local/bin`, add to your shell profile: `export PATH="$PATH:$HOME/.local/bin"`

**Permission denied:**

Make sure the binary is executable:
```bash
chmod +x /path/to/devos
```

Or use sudo for system-wide installation:
```bash
sudo mv devos /usr/local/bin/
```

**macOS security warning:**

Bypass Gatekeeper using the command line:
```bash
xattr -d com.apple.quarantine /usr/local/bin/devos
```

Or right-click the binary in Finder and select "Open" the first time.
