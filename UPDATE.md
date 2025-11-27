# Updating DevOS

DevOS makes it easy to stay up to date with the latest features and fixes.

## Check for Updates

To check if a new version is available:

```bash
devos version --check
```

You'll see output like:
```
🔍 Checking for updates...

📦 Current version: v2.17.0
📦 Latest version:  v2.18.0

✨ Update available!

To update, run:
  curl -fsSL https://raw.githubusercontent.com/devos-project/devos/latest/install.sh | sh

Or download from: https://github.com/devos-project/devos/releases/tag/v2.18.0
```

## Update Using Install Script

The easiest way to update is to re-run the install script:

```bash
curl -fsSL https://raw.githubusercontent.com/devos-project/devos/latest/install.sh | sh
```

The script will:
- Download the latest version
- Replace your existing installation
- Preserve your configuration and data

## Manual Update

1. **Download the latest binary** from [GitHub Releases](https://github.com/devos-project/devos/releases/latest)

2. **Replace the existing binary:**
   ```bash
   # Find your current installation
   which devos

   # Replace it (example for /usr/local/bin)
   sudo mv devos-linux-amd64 /usr/local/bin/devos
   chmod +x /usr/local/bin/devos
   ```

3. **Verify the update:**
   ```bash
   devos version
   ```

## What Gets Updated

- **Binary only**: The devos executable is replaced
- **Preserved**: Your project files, configuration, tasks, and data remain unchanged
- **Backward compatible**: New versions maintain compatibility with existing projects

## Release Notes

View what's new in each release:
- [CHANGELOG](https://github.com/devos-project/devos/blob/main/CHANGELOG.md)
- [Release Notes](https://github.com/devos-project/devos/releases)

## Version History

To see your current version and installed prompt templates:

```bash
devos version
```

Output:
```
DevOS Dev-Tools version v2.17.0

📋 Prompt Templates:
  • worker-guidance           v4.1.1    (updated: 2025-11-26)
  • pr-review-guidance        v3.0.2    (updated: 2025-11-26)
  ...

Run 'devos explain prompt-versioning' for versioning guidelines.
```

## Rollback to Previous Version

If you need to rollback to a previous version:

1. Visit [Releases](https://github.com/devos-project/devos/releases)
2. Download the version you want
3. Follow the manual installation steps

## Automatic Updates

DevOS does not update automatically. You control when to update by:
- Running `devos version --check` regularly
- Re-running the install script when ready
- Subscribing to [releases on GitHub](https://github.com/devos-project/devos/releases) for notifications
