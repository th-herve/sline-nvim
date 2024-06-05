local M = {}

---@return { error: number, warning: number }
M.get_count = function()
    local result = { error = 0, warning = 0 }
    result.error = #(
        vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    )
    result.warning = #(
        vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    )

    return result
end

vim.print(M.get_count())

return M
