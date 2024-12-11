local rendermarkdown = require('render-markdown')

vim.keymap.set("n", "<leader>md", function()
    rendermarkdown.toggle()
end)
