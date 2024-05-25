local set = vim.keymap.set

return {
    "stevearc/oil.nvim",
    config = function ()
        require("oil").setup({
          -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
          -- Set to false if you still want to use netrw.
          default_file_explorer = true,
         -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
          skip_confirm_for_simple_edits = false,
          -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
          -- (:help prompt_save_on_select_new_entry)
          prompt_save_on_select_new_entry = true,
          -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
          -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
          -- Additionally, if it is a string that matches "actions.<name>",
          -- it will use the mapping at require("oil.actions").<name>
          -- Set to `false` to remove a keymap
          -- See :help oil-actions for a list of all available actions
          keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
          },
          use_default_keymaps = true,
          view_options = {
            -- Show files and directories that start with "."
            show_hidden = true,
            -- This function defines what is considered a "hidden" file
            is_hidden_file = function(name, bufnr)
              return vim.startswith(name, ".")
            end,
            -- This function defines what will never be shown, even when `show_hidden` is set
            is_always_hidden = function(name, bufnr)
              return false
            end,
          },
          -- Configuration for the actions floating preview window
          preview = {
            -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_width and max_width can be a single value or a list of mixed integer/float types.
            -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
            max_width = 0.9,
            -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
            min_width = { 40, 0.4 },
            -- optionally define an integer/float for the exact width of the preview window
            width = nil,
            -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_height and max_height can be a single value or a list of mixed integer/float types.
            -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
            max_height = 0.9,
            -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
            min_height = { 5, 0.1 },
            -- optionally define an integer/float for the exact height of the preview window
            height = nil,
            border = "rounded",
            win_options = {
              winblend = 0,
            },
          },
        })

        set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
}
