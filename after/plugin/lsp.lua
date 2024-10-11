require "Bozho.remap"

-- a must: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Native LSP Setup
vim.lsp.set_log_level("warn")

-- Global setup.
local cmp = require 'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-y>'] = cmp.mapping.confirm({ select = false }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- leaving only what I actually use...
    nmap { "K", "<cmd>Lspsaga hover_doc<CR>", opts }
    nmap { "gd", "<cmd>Telescope lsp_definitions<CR>", opts }
    nmap { "<leader>lf", "<cmd>Telescope lsp_references<CR>", opts }
    nmap { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts }
    nmap { "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts }

    nmap { "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts }
    nmap { "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts }
    nmap { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts }
    nmap { "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>", opts }
    nmap { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts }
    nmap { "<leader>lD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts }
    nmap { "<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>", opts }
    nmap { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts }
    nmap { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts }
    nmap { "<leader>ld", "<cmd>Telescope diagnostics<CR>", opts }

    -- autoformat on save
    if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[
                 augroup formatting
                    autocmd! * <buffer>
                    autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                augroup END
            ]])
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.cmd([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
    end
end

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

local servers = {
    rust_analyzer = {
        filetypes = { "rust" },
        cmd = {
            "rustup", "run", "stable", "rust-analyzer",
        }
    },
    ltex = {
        diagnostics = { disable = { 'missing-fields' } },
        settings = {
            language = "en-US",
        },
        filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "html", "xhtml", "mail", "text" },
    },
    yamlls = {
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
                },
            },
        },
        cmd = { "yaml-language-server", "--stdio" },
        single_file_support = true,
    },
    gopls = {
        settings = {
            gopls = {
                gofumpt = true,
            },
        },
        flags = {
            debounce_text_changes = 150,
        },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
    },
    golangci_lint_ls = {},
    kotlin_language_server = {
        filetypes = { "kotlin" },
    },
    typescript_language_server = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "typescript.tsx" },
    },
    lua_ls = {
        single_file_support = true,
        filetypes = { "lua" },
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                    checkThirdParty = false,
                    -- Tells lua_ls where to find all the Lua files that you have loaded
                    -- for your neovim configuration.
                    library = {
                        '${3rd}/luv/library',
                        unpack(vim.api.nvim_get_runtime_file('', true)),
                    },
                },
            },
        },
    }
}

require('mason-lspconfig').setup {
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            require('lspconfig')[server_name].setup {
                cmd = server.cmd,
                settings = server.settings,
                filetypes = server.filetypes,
                flags = server.flags,
                root_dir = server.root_dir,
                -- This handles overriding only values explicitly passed
                -- by the server configuration above. Useful when disabling
                -- certain features of an LSP (for example, turning off formatting for tsserver)
                capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
                on_attach = on_attach,
            }
        end,
    },
}
