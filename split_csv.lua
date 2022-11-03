-- 🚀 [TRIM LEADING AND TRAILING SPACE AROUND STRING]
function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

-- 🚀 [SPLIT COMMA SEPARATED VALUES]
function split_csv(sel)
    local pat = "[^,]*"  -- everything except commas
    local tbl = {}
    sel:gsub(pat, function(x) tbl[#tbl+1]=trim(x)..'\n' end)
    local text = table.concat(tbl)
    return(text)
end

args = ""

-- Since KDE Kate pass all selected text as a multiple arguments splitted by comma,
-- i first need to concatenate all bits of arguments into one single string.
-- Then I can use the prepared function, modified from SciTE.

-- TODO: Improve intelligence and recognize single quotes, so I can leave commas inside single quotes untached.
-- NOTE: Check would that be usefull ?

i = 1
while arg[i] do
    args = args..arg[i]
    i = i + 1
end

print(split_csv(args))
