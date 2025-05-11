return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig.clangd.setup({
            cmd = {
                "clangd",
                "--header-insertion=never",
            },
            capabilities = capabilities;
        })

        lspconfig.pylsp.setup({
            capabilities = capabilities,
            settings = {
                pylsp = {
                    plugins = {
                        -- pyflakes: Static analysis tool
                        pyflakes = {
                            enabled = false,
                        },
                        -- mccabe: Complexity checker
                        mccabe = {
                            enabled = false,
                        },
                        -- pycodestyle: Code style checker
                        pycodestyle = {
                            enabled = false,
                        },
                    },
                },
            },
        })

        local options = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, options)
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, options)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, options)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
        vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action, options)
        vim.keymap.set("n", "<leader>sdf", vim.diagnostic.open_float, options)
        vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, options)
    end,
}
