local M = {}

local bar = require('sline.bar')
local config = require('sline.config')
local color = require('sline.color')

local augroup = vim.api.nvim_create_augroup('sline', { clear = true })

function M.setup(opts)
    if opts.enable == false then
        return
    end

    local ok, _ = pcall(require, 'nvim-web-devicons')

    if not ok then
        print('sline: web-devicons not found')
        return
    end

    config.setup(opts)
    color.setup()

    vim.api.nvim_create_autocmd({ 'BufEnter', 'DiagnosticChanged', 'LspAttach' }, {
        group = augroup,
        callback = function()
            local elem = 'winbar'
            if config.status_line then
                elem = 'statusline'
            end

            vim.o[elem] = bar.get_bar()
            color.update_icon_fg()
        end,
    })
    vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
        group = augroup,
        callback = function()
            color.update()
        end,
    })
end

return M
