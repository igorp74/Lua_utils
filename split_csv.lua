-- 🚀 [TRIM LEADING AND TRAILING SPACE AROUND STRING]
function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

-- 🚀 [SPLIT COMMA SEPARATED VALUES]
function split_csv(sel)
    local pat = "[^,']*"  -- everything except commas
    local tbl = {}
    -- TODO     Check why I do not get the single quotes back ?
    --                 at this point, it almost seems lika a feature, not a bug :)
    -- FIXME    but, what if I have some text in quotes...
    sel:gsub(pat, function(x) tbl[#tbl+1]=trim(x)..'\n' end)
    local text = table.concat(tbl)
    return(text)
end


-- Kate use one single argument in call with this function,
-- but it could be variable size of arguments since selection could be multi-word or/and multi-line,
-- so I need to prepare selected text from editor to fit into one, single argument for this function.

-- Will join all arguments into one string

args = ""
i = 1

while arg[i] do
    if i == 1 then
        args = arg[i]
    else
        args = args..' '..arg[i]
    end
    i = i + 1
end

print(split_csv(args))
