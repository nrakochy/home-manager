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
          local pickers = require("telescope.pickers")
          local finders = require("telescope.finders")
          local conf = require("telescope.config").values
          local make_entry = require("telescope.make_entry")
          local sorters = require("telescope.sorters")

          pickers
            .new({}, {
              debounce = 200,
              prompt_title = "Live Grep (pattern | dir/path pattern)",
              finder = finders.new_async_job({
                command_generator = function(prompt)
                  if not prompt or prompt == "" then
                    return nil
                  end

                  local args = vim.deepcopy(conf.vimgrep_arguments)

                  -- Check if the first token looks like a path (contains /)
                  -- Format: "dir/path pattern" or just "pattern"
                  local first_space = prompt:find(" ", 1, true)
                  local pattern, search_dir

                  if first_space then
                    local maybe_dir = prompt:sub(1, first_space - 1)
                    if maybe_dir:find("/", 1, true) then
                      search_dir = maybe_dir
                      pattern = prompt:sub(first_space + 1)
                    else
                      pattern = prompt
                    end
                  else
                    pattern = prompt
                  end

                  if pattern == "" then
                    return nil
                  end

                  table.insert(args, "-e")
                  table.insert(args, pattern)

                  if search_dir and search_dir ~= "" then
                    table.insert(args, search_dir)
                  end

                  return args
                end,
                entry_maker = make_entry.gen_from_vimgrep({}),
              }),
              previewer = conf.grep_previewer({}),
              sorter = sorters.empty(),
            })
            :find()
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
    opts = {
      extensions = {
        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
      pickers = {
        live_grep = {
          debounce = 200,
        },
        find_files = {
          debounce = 200,
          find_command = {
            "fd",
            "--type",
            "f",
            "--hidden",
            "--exclude",
            "node_modules",
            "--exclude",
            "bazel-*",
            "--exclude",
            "changes",
            "--exclude",
            "vendor",
            "--exclude",
            "*.lock",
            "--exclude",
            "*.cache",
            "--exclude",
            ".git",
          },
        },
      },
      defaults = {
        cache_picker = {
          num_pickers = 10,
        },
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
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("fzf")
    end,
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
    config = function()
      -- Derive tsserver lib path from the tsc binary that Nix puts on $PATH.
      -- In a Nix profile: bin/tsc sits next to lib/node_modules/typescript/lib/tsserver.js
      local tsc = vim.fn.exepath("tsc")
      if tsc == "" then
        vim.notify("typescript-tools: tsc not found on PATH", vim.log.levels.WARN)
        return
      end
      local bin_dir = vim.fn.fnamemodify(tsc, ":h")
      local prefix = vim.fn.fnamemodify(bin_dir, ":h")
      local tsserver_path = prefix .. "/lib/node_modules/typescript/lib/tsserver.js"
      if vim.fn.filereadable(tsserver_path) == 0 then
        vim.notify("typescript-tools: not found at " .. tsserver_path, vim.log.levels.WARN)
        return
      end
      require("typescript-tools").setup({
        settings = {
          tsserver_path = tsserver_path,
        },
      })
    end,
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
