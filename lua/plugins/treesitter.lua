return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "main",
        lazy = false,
        config = function()
            require 'nvim-treesitter.config'.setup {
                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = {
                    "c",
                    "lua",
                    "rust",
                    "kotlin",
                    "json",
                    "java",
                    "go",
                    "typescript",
                    "javascript",
                    "scala",
                    "vim"
                },
            }
        end
    },
}
