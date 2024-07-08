---@class Config
---@field depth integer
---@field status_line boolean
---@field unamed_buffer_label string
---@field contrast boolean
---@field show_mode boolean
local M = {}

local default_config = {
    depth = 1, -- number of directory in the path
    status_line = false, -- display the bar at the bottom instead of top
    unamed_buffer_label = '[ no name ]',
    contrast = true, -- should the bar be a different color than the background
    show_mode = true,
}

---@param opts Config
M.setup = function(opts)
    local new_conf = vim.tbl_deep_extend('keep', opts or {}, default_config)

    for k, v in pairs(new_conf) do
        M[k] = v
    end
end

return M
