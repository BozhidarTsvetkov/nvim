function ColorMyPencils()
    -- Transparent background
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#C3FAF0', bold = false })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = false })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#E1A9F5', bold = false })
    vim.api.nvim_set_hl(0, 'Comment', { fg = '#8EA302' })
end

ColorMyPencils()
