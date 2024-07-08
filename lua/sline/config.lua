---@class Config
---@field enable boolean
---@field depth integer
---@field status_line boolean
---@field unamed_buffer_label string
---@field contrast boolean
local M = {}

local default_config = {
    enable = true,
    depth = 1, -- number of directory in the path
    status_line = false, -- display the bar at the bottom instead of top
    unamed_buffer_label = '[ no name ]',
    contrast = false, -- should the bar be a different color than the background
}

---@param opts Config
M.setup = function(opts)
    local new_conf = vim.tbl_deep_extend('keep', opts or {}, default_config)

    for k, v in pairs(new_conf) do
        M[k] = v
    end
end

return M
