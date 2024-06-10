local winbar_colors = vim.api.nvim_get_hl(0, { name = 'Winbar' })

---@param name string highlight name
---@param elem "fg" | "bg"
local function get(name, elem)
    local hl = vim.api.nvim_get_hl(0, { name = name })
    return hl[elem]
end

local highlights = {
    SlineDirectory = { default = true, bg = get('Winbar', 'bg'), fg = get('Directory', 'fg') },
    SlineLspError = { default = true, bg = get('Winbar', 'bg'), fg = get('DiagnosticError', 'fg') },
    SlineLspWarning = { default = true, bg = get('Winbar', 'bg'), fg = get('DiagnosticWarn', 'fg') },
    SlineSeparator = { default = true, bg = get('Winbar', 'bg'), fg = get('DiagnosticWarn', 'fg') },
}

for k, v in pairs(highlights) do
    vim.api.nvim_set_hl(0, k, v)
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

M.winbar = '%#Winbar#'
M.directory = '%#SlineDirectory#'
M.lsp_warning = '%#SlineLspWarning#'
M.lsp_error = '%#SlineLspError#'
M.separator = '%#SlineSeparator#'

return M
