return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()

        local servers = {
            "lua_ls",   -- Lua & Neovim Vimdoc/API
            "clangd",   -- C & C++
            "html",     -- HTML
            "jsonls",   -- JSON
            "pyright",    -- Python
            "marksman", -- Markdown
        }

        require("mason-lspconfig").setup({
            ensure_installed = servers,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })

        for _, server_name in ipairs(servers) do
            vim.lsp.enable(server_name)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, silent = true, desc = "Go to definition" })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, silent = true, desc = "Go to declaration" })
                vim.keymap.set("n", "K", function()
                    for _ = 0, 1 do vim.lsp.buf.hover({ border = "rounded" }) end
                end, { buffer = event.buf, silent = true, desc = "Hover documentation" })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf, silent = true, desc = "Find references" })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf, silent = true, desc = "Rename symbol" })
                vim.keymap.set("n", "<leader>sdf", function()
                    for _ = 0, 1 do
                        vim.diagnostic.open_float({
                            border = "rounded",
                            source = "if_many",
                            header = "Line Diagnostics",
                            prefix = "• ",
                        })
                    end
                end, { buffer = event.buf, silent = true, desc = "Show diagnostics window" })
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, silent = true, desc = "Code actions" })
            end,
        })
    end,
}
