local M = {}

local bar = require("sline.bar")
local config = require("sline.config")
local utils = require("sline.utils")

local augroup = vim.api.nvim_create_augroup("sline", { clear = true })

function M.setup(opts)

  local ok, nvim_ts = pcall(require, "nvim-web-devicons")

  if not ok then
    print("sline: web-devicons not found")
    return
  end

  config.setup(opts)

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = augroup,
    callback = function()
      vim.o.winbar = bar.get_winbar(config)
    end,
  })
end

return M
