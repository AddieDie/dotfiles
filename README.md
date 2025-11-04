# addie-dotfiles

Personal dotfiles tuned for a lightweight Neovim (Lua) setup and a small set of VS Code UI tweaks.

This repo contains a single-file Neovim configuration (`init.lua`) and a `vscode-settings.json` to apply a compact editor layout. The README documents how to install, what the config includes, and where to customize it.

## What's in this repo

- `init.lua` — main Neovim configuration written in Lua. Bootstraps `lazy.nvim` as the plugin manager and configures colors, plugins, keymaps, and a handy C compile/run shortcut.
- `vscode-settings.json` — opinionated VS Code settings you can copy into a workspace `.vscode/settings.json` or merge into your global settings.
- `LICENSE` — repo license (see file).

## Highlights (what I added)

- Plugin manager: lazy.nvim (auto-bootstrapped in `init.lua`). Run `:Lazy sync` to install plugins.
- Colors: `sainnhe/everforest` is the default colorscheme (with `morhetz/gruvbox` available lazily).
- File explorer: `nvim-tree.lua` with <leader>e toggling the tree.
- Treesitter for syntax, LSP support (`nvim-lspconfig`), Telescope with fzf native, autopairs, and a polished statusline with `lualine`.
- Keymaps:
	- <leader>w — save file
	- <leader>q — quit
	- <D-q> — quit all (macOS Command+q mapping)
	- <leader>e — toggle Nvim Tree
	- <leader>f — Telescope find files
	- <leader>g — Telescope live grep
	- <leader>b — Telescope buffers
	- <F5> — compile & run the current C file (builds into a `./build/` directory and runs the produced binary)

## Plugin list (from `init.lua`)

Core plugins currently configured:

- folke/lazy.nvim (plugin manager)
- sainnhe/everforest (theme)
- nvim-tree/nvim-tree.lua (file explorer)
- nvim-tree/nvim-web-devicons (icons)
- nvim-treesitter/nvim-treesitter (syntax/indent)
- neovim/nvim-lspconfig (LSP)
- windwp/nvim-autopairs (auto closing pairs)
- nvim-telescope/telescope.nvim (fuzzy finder) + telescope-fzf-native
- nvim-lualine/lualine.nvim (statusline)
- morhetz/gruvbox (optional theme)

Note: `telescope-fzf-native.nvim` requires `make` to build the native extension; the config checks for `make` before attempting the build.

## Quick install (recommended)

1) Backup any existing Neovim config:

```bash
mv ~/.config/nvim ~/.config/nvim.backup-$(date +%s) 2>/dev/null || true
```

2) Clone this repo into your Neovim config directory (or keep it elsewhere and symlink):

```bash
git clone https://github.com/AddieDie/addie-dotfiles.git ~/.config/nvim
```

If you prefer to keep the repo in `~/code` and symlink only the `init.lua`:

```bash
git clone https://github.com/AddieDie/addie-dotfiles.git ~/code/addie-dotfiles
mkdir -p ~/.config/nvim
ln -sfn ~/code/addie-dotfiles/init.lua ~/.config/nvim/init.lua
```

3) Start Neovim. `init.lua` bootstraps `lazy.nvim` automatically. Once Neovim starts, run:

```vim
:Lazy sync
```

This installs the plugins defined in `init.lua`.

## Using the C compile shortcut

Press F5 while editing a C file. The mapping:

- creates a `build/` directory in the current working directory (if it doesn't exist),
- compiles the current buffer with `gcc` into `build/<filename>`,
- and runs the resulting binary.

Notes and caveats:
- The command runs `gcc` without extra flags; modify `init.lua` if you need debug flags or linking options.
- The build directory is created automatically and left on disk.

## VS Code settings

The file `vscode-settings.json` contains opinionated UI and editor settings (fonts, tabs, layout tweaks and a compact look). To use them:

- For a single workspace: copy the file to `.vscode/settings.json` inside the project.
- To merge into your user settings: open Settings (JSON) and merge the keys you like.

Highlights from the settings:

- JetBrains Mono, font size 14 and compact UI (minimap disabled, status bar hidden by default)
- relative line numbers and tab size 2
- various custom UI tweaks to simplify the look (custom styles included)

## Customization

- Edit `init.lua` directly to add/remove plugins or change options.
- Consider splitting `init.lua` into `lua/` modules if the config grows (e.g. `lua/plugins.lua`, `lua/keymaps.lua`).
- If you use a different plugin manager, adapt the plugin declarations accordingly.

## Troubleshooting

- If Neovim fails to start, move `init.lua` temporarily and start with an empty config to isolate the error:

```bash
mv ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak
nvim --clean
```

- If a plugin build fails (e.g. `telescope-fzf-native`), ensure `make` is installed and re-run `:Lazy sync`.
- If the F5 compile/run mapping doesn’t work, ensure `gcc` is installed and you are editing a `.c` file.

## Contributing & follow-ups

This repo is primarily a personal config, I'll not accept any pull request
