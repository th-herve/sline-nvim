local utils = require('sline.utils')

local M = {}

local default_config = {
  depth = 1
}

M.setup = function (opts)

  local new_conf = vim.tbl_deep_extend("keep", opts or {}, default_config)

  for k, v in pairs(new_conf) do
    M[k] = v
  end

end

return M
