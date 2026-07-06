return {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
        completion = {
            menu = {
                auto_show = true,
                border = "rounded",
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = {
                    border = "rounded",
                    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
                },
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false
                },
            },
        },
        keymap = {
            ["<C-n>"] = { "show", "select_next", "fallback" }, -- Open menu if closed, otherwise go to next
            ["<C-p>"] = { "select_prev", "fallback" },         -- Go to previous
            ["<C-y>"] = { "accept", "fallback" },              -- Confirm your selection
            ["<C-e>"] = { "hide", "fallback" },                -- Cancel / Close menu
        },
        sources = {
            default = { "snippets", "lsp", "path", "buffer" },
            providers = {
                snippets = { min_keyword_length = 2 },
                buffer = { min_keyword_length = 3 },
            },
        },
        snippets = {
            preset = "default",
        },
    },
}
