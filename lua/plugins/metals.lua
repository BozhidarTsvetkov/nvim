return {
    "scalameta/nvim-metals",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "j-hui/fidget.nvim",
            opts = {},
        },
        {
            "mfussenegger/nvim-dap",
            config = function(self, opts)
                -- Debug settings if you're using nvim-dap
                local dap = require("dap")

                dap.configurations.scala = {
                    {
                        type = "scala",
                        request = "launch",
                        name = "RunOrTest",
                        metals = {
                            runType = "runOrTestFile",
                            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                        },
                    },
                    {
                        type = "scala",
                        request = "launch",
                        name = "Test Target",
                        metals = {
                            runType = "testTarget",
                        },
                    },
                }
            end
        },
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
        local metals_config = require("metals").bare_config()

        -- Example of settings
        metals_config.settings = {
            showImplicitArguments = true,
            showImplicitConversionsAndClasses = true,
            testUserInterface = "Test Explorer",
            excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        }

        metals_config.init_options.statusBarProvider = "off"

        -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

        metals_config.on_attach = function(client, bufnr)
            require("metals").setup_dap()

            -- LSP mappings
            vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>")
            vim.keymap.set("n", "<leader>lws", "<cmd>Telescope lsp_workspace_symbols<CR>")
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
            vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
            vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>")
            vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>")
            vim.keymap.set("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>")
            vim.keymap.set("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>")
            vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>")
            vim.keymap.set("n", "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
            vim.keymap.set("n", "<leader>lf", "<cmd>Telescope lsp_references<CR>")

            vim.keymap.set("n", "<leader>ws", function()
                require("metals").hover_worksheet()
            end)

            vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

            vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

            -- Example mappings for usage with nvim-dap. If you don't use that, you can
            -- skip these
            vim.keymap.set("n", "<leader>dc", function()
                require("dap").continue()
            end)

            vim.keymap.set("n", "<leader>dr", function()
                require("dap").repl.toggle()
            end)

            vim.keymap.set("n", "<leader>dK", function()
                require("dap.ui.widgets").hover()
            end)

            vim.keymap.set("n", "<leader>dt", function()
                require("dap").toggle_breakpoint()
            end)

            vim.keymap.set("n", "<leader>dso", function()
                require("dap").step_over()
            end)

            vim.keymap.set("n", "<leader>dsi", function()
                require("dap").step_into()
            end)

            vim.keymap.set("n", "<leader>dl", function()
                require("dap").run_last()
            end)
        end

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end
}
