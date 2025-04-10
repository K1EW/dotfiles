return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    prompt_position = "top",
                },
                sorting_strategy = "ascending",
                mappings = {
                    i = {
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous
                    }
                }
            },
            extentions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown()
                }
            },
        })

        require("telescope").load_extension("ui-select")

        local builtin = require("telescope.builtin")

        local options = { noremap = true, silent = true }
        vim.keymap.set("n", "<Leader>ff", builtin.find_files, options)
        vim.keymap.set("n", "<Leader>fg", builtin.live_grep, options)
        vim.keymap.set("n", "<Leader>fb", builtin.buffers, options)
    end
}
