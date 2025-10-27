# addie-dotfiles

A minimal, personal dotfiles repository containing a Neovim configuration (`init.lua`).

## Overview

This repository contains Neovim configuration and any related dotfiles kept at the repo root. The primary entrypoint is `init.lua` which configures Neovim using Lua.

Use this repository as a starting point for a lightweight, Lua-based Neovim setup. It's intentionally small and easy to adapt.

## Repository structure

- `init.lua` — main Neovim configuration file (entrypoint).
- `README.md` — this document.

If you add more config files (e.g., `lua/`, `ftplugin/`, or other dotfiles), list them here for quick reference.

## Quick install

Clone this repository and use it as your Neovim configuration. Replace the target path if you prefer a different layout.

1) Backup any existing Neovim config first:

```bash
mv ~/.config/nvim ~/.config/nvim.backup-$(date +%s) 2>/dev/null || true
```

2) Clone this repo into the Neovim config path:

```bash
git clone https://github.com/AddieDie/addie-dotfiles.git ~/.config/nvim
```

Alternatively, keep the repo somewhere else and symlink the `init.lua` into `~/.config/nvim/init.lua`:

```bash
git clone https://github.com/AddieDie/addie-dotfiles.git ~/code/addie-dotfiles
mkdir -p ~/.config/nvim
ln -sfn ~/code/addie-dotfiles/init.lua ~/.config/nvim/init.lua
```

3) Open Neovim and follow any plugin manager instructions to install plugins. For many setups this will be one of the following inside Neovim:

- `:PackerSync` (packer.nvim)
- `:Lazy` or `:Lazy sync` (lazy.nvim)
- or the equivalent command for the plugin manager used in this config

If the config uses a plugin manager that isn't installed, install it per that manager's README before running the sync/install command.

## Usage

- Edit `init.lua` to customize settings, keymaps, and plugins.
- To reload changes during a session: inside Neovim run `:luafile $MYVIMRC` or restart Neovim.
- Keep your secrets and machine-specific settings out of this repository (use a `local.lua` or environment-specific file if needed).

## Customization tips

- Split large configs into `lua/` modules (e.g., `lua/plugins.lua`, `lua/settings.lua`) for clarity.
- Use `vim.opt` for options and `vim.keymap.set()` for mappings when editing `init.lua`.
- Consider adding a `Makefile` or small install script to automate symlinks and plugin bootstrapping.

## Troubleshooting

- If Neovim won't start, move your `init.lua` out of the way and start with a minimal file to reproduce the issue.
- Check `:messages` for runtime error traces.
- If plugins fail to install, ensure your plugin manager is installed and run the manager's sync/install command in Neovim.

## Contributing

This repository is primarily a personal configuration. Contributions are welcome as issues or PRs; please keep changes minimal and well-documented. If you want to suggest a new feature, open an issue first so we can discuss scope.

## License

This repository includes a `LICENSE` file. See it for license details.

