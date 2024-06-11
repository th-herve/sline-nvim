local M = {}

local bar = require('sline.bar')
local config = require('sline.config')

local augroup = vim.api.nvim_create_augroup('sline', { clear = true })

function M.setup(opts)
    local ok, _ = pcall(require, 'nvim-web-devicons')

    if not ok then
        print('sline: web-devicons not found')
        return
    end

    config.setup(opts)

    vim.api.nvim_create_autocmd({ 'BufEnter', 'LspTokenUpdate' }, {
        group = augroup,
        callback = function()
            local elem = 'winbar'
            if config.status_line then
                elem = 'statusline'
            end

            vim.o[elem] = bar.get_winbar()
        end,
    })
    vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
        group = augroup,
        callback = function()
            require('sline.color').set_highlights()
        end,
    })
end

return M
