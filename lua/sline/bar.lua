local devicon = require('nvim-web-devicons')
local win_hl = '%#WinBar#'

local M = {}

local function get_breadcrum(depth)
    local filename = vim.fn.expand('%:t')
    filename = (filename == '' and '[ no name ]' or filename)

    local extension = vim.fn.expand('%:e')

    local directories = vim.fn.expand('%:p:h')
    local dirs_list = vim.split(directories, '/') -- break path into all directories

    local max = #dirs_list
    local min = #dirs_list - depth + 1
    if min < 1 then
        min = 1
    end

    local dir_bar = ''

    if min < max then
        dir_bar = '%#Directory#󰉋 '
        for i = min, max, 1 do
            local next_dir = dirs_list[i]
            dir_bar = dir_bar .. win_hl .. next_dir .. '%#WarningMsg#' .. ' > '
        end
    end

    local icon, icon_hl =
        devicon.get_icon(filename, extension, { default = true })

    return dir_bar
        .. '%#'
        .. icon_hl
        .. '#'
        .. icon
        .. win_hl
        .. ' '
        .. filename
end

local function get_diagnostics()
    local count = require('sline.diagnostics').get_count()

    return '%#DiagnosticError#'
        .. ' '
        .. count.error
        .. ' '
        .. '%#DiagnosticWarn#'
        .. ' '
        .. count.warning
end

local function get_git_branch()
    local branch =
        vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

    if branch ~= '' then
        branch = '%#Directory#  ' .. win_hl .. branch
    end
    return branch
end

---@return string
M.get_winbar = function(opts)
    return get_breadcrum(opts.depth)
        .. '%='
        .. get_diagnostics()
        .. '   '
        .. get_git_branch()
end

return M
