-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- -- use jk to exit insert mode
local keymap = vim.keymap -- for conciseness
keymap.set({ "i", "t" }, "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set(
  { "n" },
  "gb",
  "<cmd>lua vim.lsp.buf.definition({  split = 'vertical' })<CR>",
  { desc = "Go to side definition" }
)
