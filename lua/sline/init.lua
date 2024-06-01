local M = {}

local bar = require("sline.bar")

local augroup = vim.api.nvim_create_augroup("sline", { clear = true })

function M.setup()
  local ok, nvim_ts = pcall(require, "nvim-web-devicons")

  if not ok then
    print("sline: web-devicons not found")
    return
  end

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = augroup,
    callback = function()
      print("hello")
      vim.o.winbar = bar.get_winbar()
    end,
  })
end

return M
