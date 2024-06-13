local devicon = require('nvim-web-devicons')

---@param name string highlight name
---@param elem "fg" | "bg"
---@return string color
local function get(name, elem)
    local hl = vim.api.nvim_get_hl(0, { name = name })
    return hl[elem]
end

---@alias highlight string

---@class Color
---@field winbar highlight
---@field directory highlight
---@field lsp_warning highlight
---@field lsp_error highlight
---@field git_sign highlight
---@field separator highlight
local M = {}

M.set_highlights = function()
    local highlights = {
        SlineDirectory = { default = true, bg = get('Winbar', 'bg'), fg = get('Directory', 'fg') },
        SlineLspError = { default = true, bg = get('Winbar', 'bg'), fg = get('DiagnosticError', 'fg') },
        SlineLspWarning = { default = true, bg = get('Winbar', 'bg'), fg = get('DiagnosticWarn', 'fg') },
        SlineSeparator = { default = true, bg = get('Winbar', 'bg'), fg = get('DiagnosticWarn', 'fg') },
        SlineWinbar = { default = true, bg = get('Winbar', 'bg'), fg = get('Winbar', 'fg') },
    }
    for k, v in pairs(highlights) do
        vim.api.nvim_set_hl(0, k, v)
    end
end
M.set_highlights()

M.get_icon = function(filename, extension)
    local icon, icon_hl = devicon.get_icon(filename, extension, { default = true })

    local icon_hl_data = vim.api.nvim_get_hl(0, { name = icon_hl })

    vim.api.nvim_set_hl(0, 'SlineIcon', { default = true, bg = get('WinBar', 'bg'), fg = icon_hl_data.fg })

    return icon, M.icon
end

M.update_icon = function()
    local _, color = devicon.get_icon_colors(vim.fn.expand('%:t'), vim.fn.expand('%:e'), { default = true })

    vim.api.nvim_set_hl(0, 'SlineIcon', { default = true, bg = get('WinBar', 'bg'), fg = color })
    vim.cmd('highlight SlineIcon guifg=' .. color)
end

M.winbar = '%#SlineWinbar#'
M.icon = '%#SlineIcon#'
M.directory = '%#SlineDirectory#'
M.lsp_warning = '%#SlineLspWarning#'
M.lsp_error = '%#SlineLspError#'
M.separator = '%#SlineSeparator#'

return M
