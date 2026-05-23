return {
    "stevearc/oil.nvim",
    ---@module "oil"
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            delete_to_trash = true, -- Send deleted files to system trash
            view_options = {
                show_hidden = true, -- Show dotfiles/hidden files
            },
            keymaps = {
                -- Disable default splits to prevent conflicts with window navigation
                ["<C-h>"] = false,
                ["<C-l>"] = false,
            },
        })
        -- Open file explorer
        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { silent = true, desc = "Open parent directory in Oil" })
    end,
}
