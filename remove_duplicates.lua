-- 🚀 [Collect lines]
function lines(str)
  local t = {}
  local i, lstr = 1, #str
  while i <= lstr do
    local x, y = string.find(str, "\r?\n", i)
    if x then t[#t + 1] = string.sub(str, i, x - 1)
    else break
    end
    i = y + 1
  end
  if i <= lstr then t[#t + 1] = string.sub(str, i) end
  return t
end

-- 🚀 [Remove duplicates]
function remove_duplicates(sel)
  local hash = {}
  local res = {}

  if #sel == 0 then return end

  local eol = string.match(sel, "\n$")
  local buf = lines(sel)

  for _,v in ipairs(buf) do
    if (not hash[v]) then
       res[#res+1] = v
       hash[v] = true
    end
  end

  local out = table.concat(res, "\n")
  return(out)
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


print(remove_duplicates(arg[1]))

