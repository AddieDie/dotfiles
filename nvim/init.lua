vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.o.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<D-q>", ":qa!<CR>", { noremap = true, silent = true, desc = "Quit all" })
vim.keymap.set('n', '<leader>r', ':F1<CR>:!python3 %<CR>', { noremap = true, silent = true })


-- Python runner with split terminal
vim.keymap.set('n', '<F6>', function()
  local file = vim.fn.expand('%:p')
  if vim.fn.expand('%:e') ~= 'py' then
    print("⚠️ Not a Python file!")
    return
  end
  vim.cmd('w')  -- save before running

  -- Close any previous "run" terminal if it exists
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(buf):match("term://.*python3") then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  -- Open bottom terminal split and run Python
  vim.cmd('botright 10split | terminal python3 "' .. file .. '"')
  vim.cmd('startinsert')
end, { noremap = true, silent = true, desc = "Run Python file cleanly" })


-- Shortcut for c files | Also works for windows the shortcut is F5
-- vim.keymap.set('n', '<F5>', function()
-- local file = vim.fn.expand('%:p')       
-- local filename = vim.fn.expand('%:t:r') 
-- local build_dir = vim.fn.getcwd() .. '/build'
-- local output = build_dir .. '/' .. filename

-- -- Little caution this ll create a build file that files don't have = More storage
-- if vim.fn.isdirectory(build_dir) == 0 then
--   vim.fn.mkdir(build_dir, 'p')
--   print("📁 Created build directory: " .. build_dir)
--   end

  
--   local cmd = string.format("gcc %s -o %s && %s", file, output, output)
--   vim.cmd('!clear')  
--   vim.cmd('!' .. cmd)
--   end, { noremap = true, silent = false, desc = "Compile & run C file" })


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    {
      "sainnhe/everforest",
      lazy = false,
      priority = 1000,
      config = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_transparent_background = 1
      vim.g.everforest_enable_italic = true
      vim.cmd("colorscheme everforest")
      end
    },

    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
      end
    },

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

    { "neovim/nvim-lspconfig" },

    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
      require("nvim-autopairs").setup({})
      end
    },

    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          cond = function() return vim.fn.executable("make") == 1 end,
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

      vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
      vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
      end
    },

    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
      require("lualine").setup({
        options = {
          theme = "everforest", -- you can change this to "gruber-darker" if you prefer
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          icons_enabled = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "nvim-tree" },
      })
      end
    },



    -- New theme agine u can put any theme u want
    {
      "morhetz/gruvbox",
      lazy = true,
      config = function()
      vim.cmd("colorscheme gruber-darker")
      end
    },

  })
