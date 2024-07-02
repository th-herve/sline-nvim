local devicon = require('nvim-web-devicons')

---@alias highlight string %#highlight_group#

---@param name string highlight name
---@param elem "fg" | "bg"
---@return string color
local function get(name, elem)
    local hl = vim.api.nvim_get_hl(0, { name = name })
    return hl[elem]
end

local function get_icon_fg()
    local _, color = devicon.get_icon_colors(vim.fn.expand('%:t'), vim.fn.expand('%:e'), { default = true })
    return color
end

---@class Color
---@field winbar highlight
---@field directory highlight
---@field lsp_warning highlight
---@field lsp_error highlight
---@field git_sign highlight
---@field separator highlight
local M = {}

M.bg = ''

M.winbar = '%#SlineWinbar#'
M.icon = '%#SlineIcon#'
M.directory = '%#SlineDirectory#'
M.lsp_warning = '%#SlineLspWarning#'
M.lsp_error = '%#SlineLspError#'
M.separator = '%#SlineSeparator#'

M.set_highlights = function()
    M.bg = get('Normal', 'bg')
    local highlights = {
        SlineDirectory = { default = true, bg = M.bg, fg = get('Directory', 'fg') },
        SlineLspError = { default = true, bg = M.bg, fg = get('DiagnosticError', 'fg') },
        SlineLspWarning = { default = true, bg = M.bg, fg = get('DiagnosticWarn', 'fg') },
        SlineSeparator = { default = true, bg = M.bg, fg = get('DiagnosticWarn', 'fg') },
        SlineWinbar = { default = true, bg = M.bg, fg = get('Normal', 'fg') },
        SlineIcon = { default = true, bg = M.bg, fg = get_icon_fg() },
    }
    for k, v in pairs(highlights) do
        vim.api.nvim_set_hl(0, k, v)
    end
end

M.set_highlights()

M.update_icon_fg = function()
    local fg = get_icon_fg()
    vim.cmd('highlight SlineIcon guifg=' .. fg) -- using vim.api.nvim_set_hl does not work, dk why
end

return M
