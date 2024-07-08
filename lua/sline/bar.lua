---@alias bar_element string

local config = require('sline.config')
local color = require('sline.color')
local devicon = require('nvim-web-devicons')

local empty_element = ''

local M = {}

---@return bar_element
local function get_breadcrum(depth)
    local filename = vim.fn.expand('%:t')
    filename = (filename == '' and config.unamed_buffer_label or filename)

    local extension = vim.fn.expand('%:e')

    local directories = vim.fn.expand('%:p:h')
    local dirs_list = vim.split(directories:sub(2), '/') -- :sub(2) remove the leading '/'

    local max = #dirs_list
    local min = #dirs_list - depth + 1
    if min < 1 then
        min = 1
    end

    local dir_bar = ''

    if min <= max then
        dir_bar = color.directory .. ' 󰉋 '
        for i = min, max do
            local next_dir = dirs_list[i]
            dir_bar = dir_bar .. color.bar .. next_dir .. color.separator .. ' > '
        end
    end

    local icon, _ = devicon.get_icon(filename, extension, { default = true })

    return dir_bar .. color.icon .. icon .. color.bar .. ' ' .. filename
end

---@return bar_element
local function get_diagnostics()
    if #(vim.lsp.get_clients({ bufnr = 0 })) == 0 then
        return empty_element
    end

    local count = require('sline.diagnostics').get_count()

    return color.lsp_error .. ' ' .. count.error .. ' ' .. color.lsp_warning .. ' ' .. count.warning
end

---@return bar_element
local function get_git_branch()
    local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

    if branch ~= '' then
        branch = color.directory .. ' ' .. color.bar .. branch
    end
    return branch
end

---@return bar_element
local function get_mode()
    local mode = vim.api.nvim_get_mode().mode
    if mode == '\22' then -- visual block
        mode = 'V'
    elseif mode == 'nt' then -- terminal
        mode = 't'
    end
    return color.mode .. ' ' .. mode
end

M.get_bar = function()
    local path = get_breadcrum(config.depth)
    local diag = get_diagnostics()
    local branch = get_git_branch()
    local mode = get_mode()

    local bar = color.bar .. mode .. ' ' .. path .. ' %= ' .. diag .. '   ' .. branch .. ' '

    return bar
end

return M
