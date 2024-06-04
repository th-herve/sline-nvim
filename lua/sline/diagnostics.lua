
---@return table { error=num, warning=num }
local function get_count()
  local result = { error = 0, warning = 0 }
  result.error = #(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }))
  result.warning = #(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }))

  return result
end

vim.print(get_count())

return {
  get_count = get_count
}
