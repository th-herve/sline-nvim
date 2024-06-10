---@alias highlight string

---@class Color
---@field directory highlight
---@field lsp_warning highlight
---@field lsp_error highlight
---@field git_sign highlight
---@field separator highlight
local M = {}

M.directory = '%#Directory#'
M.lsp_warning = '%#WarningMsg#'
M.separator = M.lsp_warning

return M
