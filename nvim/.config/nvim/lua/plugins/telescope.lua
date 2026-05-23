return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { silent = true, desc = "Find project files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { silent = true, desc = "Live grep search text" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers,    { silent = true, desc = "Find open buffers" })
    end,
}
