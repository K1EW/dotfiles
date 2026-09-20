return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
        local mason_dap = require("mason-nvim-dap")
        local dap = require("dap")
        local ui = require("dapui")

        mason_dap.setup({
            ensure_installed = { "cppdbg" },
            automatic_installation = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        })

        -- Configurations
        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = function()
                    local input_file = vim.fn.input("Input file (blank for none): ", "input.txt", "file")
                    if input_file == "" then
                        return {}
                    end
                    return { "<", input_file }
                end,
                MIMode = "gdb",
                miDebuggerPath = "/usr/sbin/gdb",
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "Enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
            {
                name = "Launch (no input redirect)",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                MIMode = "gdb",
                miDebuggerPath = "/usr/bin/gdb",
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "Enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
        }
        dap.configurations.c = dap.configurations.cpp

        -- Dap UI
        ui.setup()

        -- Signs
        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint" })
        vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "DapStopped", linehl = "DapStoppedLine" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "DapBreakpoint" })

        -- Auto open/close dapui. `after.event_initialized` fires once the session is ready.
        dap.listeners.after.event_initialized["dapui_config"] = function()
            ui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            ui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            ui.close()
        end

        -- Keymaps
        local keymap = vim.keymap.set
        keymap("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
        keymap("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
        keymap("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
        keymap("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
        keymap("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        keymap("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
        keymap("n", "<leader>du", ui.toggle, { desc = "Debug: Toggle UI" })
        keymap({ "n", "v" }, "<leader>dh", function()
            require("dap.ui.widgets").hover()
        end, { desc = "Debug: Hover Variables" })
    end,
}
