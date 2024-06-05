---@class Config
---@field depth integer
---@field status_line boolean
local M = {}

local default_config = {
    depth = 1,
    status_line = false,
}

---@param opts Config
M.setup = function(opts)
    local new_conf = vim.tbl_deep_extend('keep', opts or {}, default_config)

    for k, v in pairs(new_conf) do
        M[k] = v
    end
end

return M
