-- SciTE Lua script adaptation for KDE Kate

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

-- 🚀[ Difference between 2 Lua table structures]
function tbl_diff(a, b)
    local aa = {}
    for k,v in pairs(a) do aa[v]=true end
    for k,v in pairs(b) do aa[v]=nil end
    local ret = {}
    local n = 0
    for k,v in pairs(a) do
        if aa[v] then n=n+1 ret[n]=v end
    end
    return ret
end

local function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
end

-- 🚀 [ LINE ANALYSIS ]
-- Show only duplicate lines
function duplicate_lines(sel)
    local hash  = {}
    local hash2 = {}
    local res   = {}
    local dup   = {}
    local dlc   = 0 -- duplicates line counter

    if #sel == 0 then return end

    local eol = string.match(sel, "\n$")
    local buf = lines(sel)


    for k,v in ipairs(buf) do
        -- Checking non-duplicates
        if (not hash[v]) then
           hash[v] = true
        -- Collect duplicates
        else
            if (not hash2[v]) then
                table.insert(dup,v)
                hash2[v] = true
                dlc = dlc + 1
            end
        end
    end

    -- Sorting results table
    table.sort(dup)
    local duplicates   = table.concat(dup, "\n")

    if eol then duplicates = duplicates.."\n" end

    print('⚖ Duplicates: '..tostring(dlc))
    print('--------------------------------')
    print(duplicates)
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

duplicate_lines(args)
