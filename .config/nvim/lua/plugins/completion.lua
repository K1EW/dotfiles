return {
    {
        "github/copilot.vim",
        config = function()
            vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
              expr = true,
              replace_keycodes = false
            })
            vim.g.copilot_no_tab_map = true
        end
    },
    {
        -- Snippet engine
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets"
        }
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet engine source
            "saadparwaiz1/cmp_luasnip",
            -- Buffer source
            "hrsh7th/cmp-buffer",
            -- Lsp source
            "hrsh7th/cmp-nvim-lsp",
            -- Filesystem path source
            "hrsh7th/cmp-path",
            -- Nvim Lua source
            "hrsh7th/cmp-nvim-lua"
        },
        config = function()
            local lua_snip = require("luasnip")
            local cmp = require("cmp")

            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = {
                    "./snippets"
                }
            })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        lua_snip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ select = true })
                        elseif lua_snip.expand_or_jumpable() then
                            lua_snip.expand_or_jump()
                        else
                            fallback()
                        end
                    end,
                    ["<C-c>"] = cmp.mapping.close(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-j>"] = cmp.mapping(function(fallback)
                        if lua_snip.jumpable(-1) then
                            lua_snip.jump(-1)
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                    ["<C-k>"] = cmp.mapping(function(fallback)
                        if lua_snip.jumpable(1) then
                            lua_snip.jump(1)
                        else
                            fallback()
                        end
                    end, {"i", "s"}),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer", keyword_length = 5 },
                    { name = "path" },
                }),
                window = {
                    -- completion = cmp.config.window.bordered({
                    --     border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
                    -- }),
                    documentation = {
                        max_height = 20
                    }
                },
                formatting = {
                    format = function(entry, vim_item)
                        -- Get the width of the current window
                        local win_width = vim.api.nvim_win_get_width(0)

                        -- Set the maximum completion width to 20% of the window width
                        local max_completion_width = math.floor(win_width * 0.2)

                        -- Truncate the completion item if it's longer than the maximum completion width
                        if #vim_item.abbr > max_completion_width then
                            vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, max_completion_width - 3) .. "..."
                        else
                            vim_item.abbr = vim_item.abbr .. string.rep(" ", max_completion_width - #vim_item.abbr)
                        end

                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            nvim_lua = "[Nvim]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end
                },
            })
        end
    }
}
