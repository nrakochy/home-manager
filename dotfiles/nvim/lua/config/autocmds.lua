-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Format-on-save is handled by LazyVim's conform.nvim integration:
--   - Prettier extra: runs prettierd for TS/TSX/JS/JSON/CSS/SCSS (reads .prettierrc)
--   - ESLint extra: runs EslintFixAll for import sorting (simple-import-sort) and lint fixes
-- Do NOT call vim.lsp.buf.format() here — it bypasses conform and uses vtsls's
-- built-in formatter which ignores .prettierrc.

-- Go: gopls's organizeImports adds missing imports (runs goimports internally)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(ev)
    vim.keymap.set("n", "<leader>Fi", function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end, { buffer = ev.buf, desc = "Add missing imports" })
  end,
})

-- Rust: no bulk "add all missing imports" in rust-analyzer; this triggers
-- code actions on the current symbol so you can pick the import suggestion.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function(ev)
    vim.keymap.set("n", "<leader>Fi", function()
      vim.lsp.buf.code_action()
    end, { buffer = ev.buf, desc = "Import action (pick from suggestions)" })
  end,
})
