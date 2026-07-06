return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    init = function()
        local ensure_installed = {
            "lua",
            "c",
            "cpp",
            "html",
            "json",
            "python",
            "markdown",
            "markdown_inline",
            "ocaml"
        }

        -- Diffs against already installed parsers so it doesn't slow down startup
        local already_installed = require("nvim-treesitter.config").get_installed()
        local parsers_to_install = vim.iter(ensure_installed)
            :filter(function(parser)
                return not vim.tbl_contains(already_installed, parser)
            end)
            :totable()

        if #parsers_to_install > 0 then
            require("nvim-treesitter").install(parsers_to_install)
        end

        -- Manually handle Highlighting and Indentation via Autocmds
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                -- Safely start treesitter highlighting and drop legacy regex syntax
                pcall(vim.treesitter.start)
                -- Enable tree-sitter-based indentation expr
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
    config = function()
        require("nvim-treesitter").setup({})
    end,
}
