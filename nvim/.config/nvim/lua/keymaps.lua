vim.g.mapleader = " "

-- Insert Mode
vim.keymap.set("i", "jk", "<ESC>", { silent = true, desc = "Exit insert mode smoothly" })

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Navigate to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Navigate to the bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Navigate to the top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Navigate to the right window" })

-- Window Resizing
vim.keymap.set("n", "<A-h>", "<C-w>5<", { silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<A-l>", "<C-w>5>", { silent = true, desc = "Increase window width" })
vim.keymap.set("n", "<A-j>", "<C-w>-",  { silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<A-k>", "<C-w>+",  { silent = true, desc = "Increase window height" })

-- Buffer & Config Management
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "<leader>xx", "<cmd>restart<CR>", { silent = true, desc = "Restart Neovim configuration" })

-- Text Editing & Indentation
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv-gv", { silent = true, desc = "Move selected block down" })
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv-gv", { silent = true, desc = "Move selected block up" })
vim.keymap.set("v", "<", "<gv", { silent = true, desc = "Indent left and retain visual selection" })
vim.keymap.set("v", ">", ">gv", { silent = true, desc = "Indent right and retain visual selection" })

-- Navigation Tweaks
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, desc = "Scroll half page down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, desc = "Scroll half page up and center cursor" })

-- Clipboard & Register Management
vim.keymap.set("x", "p", '"_dP', { silent = true, desc = "Paste text without overwriting clipboard register" })
vim.keymap.set("n", "d", '"_d',  { silent = true, desc = "Delete text without cutting to register" })
vim.keymap.set("v", "d", '"_d',  { silent = true, desc = "Delete selection without cutting to register" })
vim.keymap.set("n", "c", '"_c',  { silent = true, desc = "Change text without cutting to register" })
vim.keymap.set("n", "<Leader>d", "d", { silent = true, desc = "Cut text to system/default register" })
vim.keymap.set("v", "<Leader>d", "d", { silent = true, desc = "Cut selection to system/default register" })

-- Native Undo-tree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { silent = true, desc = "Open NeoVim builtin undo-tree" })
