-- System & Environment
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.termguicolors = true            -- True color support
vim.opt.virtualedit = "block"           -- Allow free cursor movement in visual block

-- UI & Display
vim.opt.number = true                   -- Show absolute line number
vim.opt.relativenumber = true           -- Show relative line numbers
vim.opt.scrolloff = 10                  -- Lines of context to keep above/below cursor
vim.opt.wrap = false                    -- Disable line wrapping
vim.opt.guicursor = "n-v-i-c:block"     -- Force block cursor in common modes
vim.opt.showmode = false                -- Hide mode text (e.g. -- INSERT --)

-- Splits & Command Line
vim.opt.splitbelow = true               -- Horizontal splits open below
vim.opt.splitright = true               -- Vertical splits open to the right
vim.opt.cmdheight = 0                   -- Hide command line when not in use

-- Tabs & Indentation
vim.opt.expandtab = true                -- Convert tabs to spaces
vim.opt.smartindent = true              -- Insert indents automatically
vim.opt.tabstop = 4                     -- 4 spaces = 1 tab
vim.opt.shiftwidth = 4                  -- Indent size for autoindent

-- Search & Substitution
vim.opt.ignorecase = true               -- Ignore case in search
vim.opt.smartcase = true                -- Case-sensitive if capitals are used
vim.opt.hlsearch = false                -- Clear search highlights
vim.opt.inccommand = "split"            -- Preview substitutions in a split

-- Completion Menu
vim.opt.pumheight = 10                  -- Max items in popup menu
vim.opt.completeopt = {                 -- Completion behavior options
    "menuone",
    "noinsert",
    "noselect",
}

-- Backups & Undo History
vim.opt.swapfile = false                -- Disable swap files
vim.opt.backup = false                  -- Disable backup files
vim.opt.undofile = true                 -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Undo storage path
