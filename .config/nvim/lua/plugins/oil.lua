return {
	"stevearc/oil.nvim",
	---@module "oil"
	dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
        require("oil").setup({
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false
            }
        })

        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { noremap = true, silent = true })
    end
}
