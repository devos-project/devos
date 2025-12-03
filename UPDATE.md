# Updating dt

## Check for Updates

Run the built-in update check:

```bash
dt version --check
```

This compares your installed version against the latest release.

Example output:
```
🔍 Checking for updates...

📦 Current version: v3.0.0
📦 Latest version:  v3.1.0

✨ Update available!

To update, run:
  curl -fsSL https://raw.githubusercontent.com/devos-project/dt/latest/install.sh | sh

Or download from: https://github.com/devos-project/dt/releases/tag/v3.1.0
```

## Update Methods

### Automatic Update (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/devos-project/dt/latest/install.sh | sh
```

This downloads and installs the latest version automatically.

### Manual Update

**1. Download the latest binary** from [GitHub Releases](https://github.com/devos-project/dt/releases/latest)

**2. Find your current installation**
```bash
which dt
```

**3. Replace the binary**
```bash
sudo mv dt-linux-amd64 /usr/local/bin/dt
```

**4. Make executable**
```bash
chmod +x /usr/local/bin/dt
```

**5. Verify**
```bash
dt version
```

## What Gets Updated

- **Binary only**: The dt executable is replaced
- **No configuration changes**: Your settings are preserved
- **No data loss**: Task files and team configurations remain intact

## Release Notes

See [CHANGELOG](https://github.com/devos-project/dt/blob/main/CHANGELOG.md) for detailed release notes.
