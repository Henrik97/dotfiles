-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v", "o" }, "<Up>", "k", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "<Down>", "j", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "<Left>", "h", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "<Right>", "l", { noremap = true, silent = true })

vim.keymap.set("n", "<A-Up>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Left>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", "<C-w>l", { noremap = true, silent = true })
