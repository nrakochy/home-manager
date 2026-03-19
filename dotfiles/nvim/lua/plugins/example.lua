-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  "tpope/vim-fugitive",
  "rhysd/git-messenger.vim",
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^8",
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
            },
          },
        },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  { "folke/trouble.nvim", enabled = false },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        { desc = "[S]earch [H]elp" },
      },
      {
        "<leader>sk",
        function()
          require("telescope.builtin").keymaps()
        end,
        { desc = "[S]earch [K]eymaps" },
      },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files()
        end,
        { desc = "[S]earch [F]iles" },
      },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").builtin()
        end,
        { desc = "[S]earch [S]elect Telescope" },
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string()
        end,
        { desc = "[S]earch current [W]ord" },
      },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").live_grep()
        end,
        { desc = "[S]earch by [G]rep" },
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        { desc = "[S]earch [D]iagnostics" },
      },
      {
        "<leader>sr",
        function()
          require("telescope.builtin").resume()
        end,
        { desc = "[S]earch [R]esume" },
      },
      {
        "<leader>s.",
        function()
          require("telescope.builtin").oldfiles()
        end,
        { desc = "[S]earch Recent Files ('.' for repeat)" },
      },
      {
        "<leader><leader>",
        function()
          require("telescope.builtin").buffers()
        end,
        { desc = "[ ] Find existing buffers" },
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--glob=!node_modules/**",
          "--glob=!bazel-*/**",
          "--glob=!changes/**",
          "--glob=!vendor/**",
          "--glob=!*.lock",
          "--glob=!*.cache",
        },
        file_ignore_patterns = {
          "node_modules/",
          "bazel%-out/",
          "bazel%-bin/",
          "bazel%-lca/",
          "bazel%-testlogs/",
          "changes/",
          "vendor/",
          "%.aspect%-gazelle%.cache",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          return true
        end,
        vtsls = function(_, opts)
          return true
        end,
        ts_ls = function(_, opts)
          return true
        end,
      },
    },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    keys = {
      { "<leader>Fi", "<cmd>TSToolsAddMissingImports<CR>", desc = "Add missing imports" },
    },
    opts = {},
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "go",
        "haskell",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ron",
        "rust",
        "tsx",
        "typescript",
        "toml",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     -- add tsx and treesitter
  --     vim.list_extend(opts.ensure_installed, {
  --       "tsx",
  --       "typescript",
  --     })
  --   end,
  -- },

  {
    "hrsh7th/nvim-cmp",
  },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "prettierd",
        "eslint_d",
        "golangci-lint",
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })

      vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
}
