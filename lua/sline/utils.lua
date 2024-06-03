local function print_table(tbl)
  for k, v in pairs(tbl) do
    print(k .. " = " .. v)
  end
end


return {
  print_table = print_table
}
