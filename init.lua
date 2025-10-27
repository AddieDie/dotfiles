-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs & indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- UI
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

-- System clipboard
vim.opt.clipboard = "unnamedplus"

-- Leader key
vim.g.mapleader = " "


-- Keymaps | ADDIE: ALSO YOU CAN CREATE A KEYMAPS.LUA FILE AND PUT ALL YOUR KEYMAPS IN THERE IF YOU WANT
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
-- ADDIE: QUIT ALL KEYMAPS FOR MACOS AND LINUX
vim.keymap.set("n", "<D-q>", ":qa!<CR>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set("n", "<A-q>", ":qa!<CR>", { noremap = true, silent = true, desc = "Quit all" })


-- Package Manager: lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    -- ADDIE: YOU CAN PUY ANY THEME YOU LIKE HERE
    {
      "sainnhe/everforest",
      lazy = false,
      priority = 1000,
      config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_enable_italic = true
      vim.cmd("colorscheme everforest")
      end
    },

    -- File explorer
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
      end
    },

    -- Syntax highlighting
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "c", "cpp", "python", "javascript", "html", "css" },
        highlight = { enable = true },
        indent = { enable = true },
      })
      end
    },

    -- LSP 
  { "neovim/nvim-lspconfig" },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
    require("nvim-autopairs").setup({})
    end
  },

  -- FZF
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
        return vim.fn.executable("make") == 1
        end,
      },
    },
    config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
    })

  pcall(telescope.load_extension, "fzf")

  -- FZF keymaps
  vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
  vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
  vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
  end
  },
  })
