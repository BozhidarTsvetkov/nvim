function ColorMyPencils()
    -- Transparent background
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#003366', bold = false })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = 'black', bold = false })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#800000', bold = false })
    vim.api.nvim_set_hl(0, 'Comment', { fg = '#8EA302' })
end

ColorMyPencils()
