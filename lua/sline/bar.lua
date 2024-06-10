---@alias bar_element string

---@type Config
local config = require('sline.config')

---@type Color
local color = require('sline.color')

local devicon = require('nvim-web-devicons')
local win_hl = '%#WinBar#'
local empty_element = ''

local M = {}

---@return bar_element
local function get_breadcrum()
    local filename = vim.fn.expand('%:t')
    filename = (filename == '' and config.unamed_buffer_label or filename)

    local extension = vim.fn.expand('%:e')

    local directories = vim.fn.expand('%:p:h')
    directories = directories:sub(2) -- remove leading '/'
    local dirs_list = vim.split(directories, '/')

    local max = #dirs_list
    local min = #dirs_list - config.depth + 1
    if min < 1 then
        min = 1
    end

    local dir_bar = ''

    if min <= max then
        dir_bar = color.directory .. '󰉋 '
        for i = min, max, 1 do
            local next_dir = dirs_list[i]
            dir_bar = dir_bar .. win_hl .. next_dir .. color.separator .. ' > '
        end
    end

    local icon, icon_hl = devicon.get_icon(filename, extension, { default = true })

    return dir_bar .. '%#' .. icon_hl .. '#' .. icon .. win_hl .. ' ' .. filename
end

---@return bar_element
local function get_diagnostics()
    if #(vim.lsp.buf_get_clients()) == 0 then
        return empty_element
    end

    local count = require('sline.diagnostics').get_count()

    return '%#DiagnosticError#' .. ' ' .. count.error .. ' ' .. '%#DiagnosticWarn#' .. ' ' .. count.warning
end

---@return bar_element
local function get_git_branch()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

    if branch ~= '' then
        branch = '%#Directory#  ' .. win_hl .. branch
    end
    return branch
end

---@return bar_element
M.get_winbar = function()
    return get_breadcrum() .. '%=' .. get_diagnostics() .. '   ' .. get_git_branch()
end

return M
