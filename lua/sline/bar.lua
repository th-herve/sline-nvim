---@alias bar_element string

---@type Config
local config = require('sline.config')

---@type Color
local color = require('sline.color')

local devicon = require('nvim-web-devicons')
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
        dir_bar = color.directory .. ' 󰉋 '
        for i = min, max, 1 do
            local next_dir = dirs_list[i]
            dir_bar = dir_bar .. color.winbar .. next_dir .. color.separator .. ' > '
        end
    end

    local icon, icon_hl = color.get_icon(filename, extension)

    return dir_bar .. icon_hl .. icon .. color.winbar .. ' ' .. filename
end

---@return bar_element
local function get_diagnostics()
    if #(vim.lsp.get_clients({ bufnr = 0 })) == 0 then
        return empty_element
    end

    local count = require('sline.diagnostics').get_count()

    return color.lsp_error .. ' ' .. count.error .. ' ' .. color.lsp_warning .. ' ' .. count.warning
end

---@return bar_element
local function get_git_branch()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

    if branch ~= '' then
        branch = color.directory .. ' ' .. color.winbar .. branch
    end
    return branch
end

---@return bar_element
M.get_winbar = function()
    return get_breadcrum() .. '%=' .. get_diagnostics() .. '   ' .. get_git_branch() .. ' '
end

return M
