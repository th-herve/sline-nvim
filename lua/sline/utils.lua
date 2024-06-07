function P(tbl)
    vim.print(tbl)
end

local clock = os.clock

function SLEEP(n) -- seconds
    local t0 = clock()
    while clock() - t0 <= n do
    end
end
