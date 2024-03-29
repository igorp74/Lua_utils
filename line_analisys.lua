-- Scite Lua script adaptation for Kate

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
function line_analysis(sel)
    local hash  = {}
    local hash2 = {}
    local res   = {}
    local dup   = {}
    local tlc   = 0 -- total line counter
    local dlc   = 0 -- duplicates line counter
    
    if #sel == 0 then return end

    local eol = string.match(sel, "\n$")
    local buf = lines(sel)

    for k,v in ipairs(buf) do
        if (not hash[v]) then
           res[#res+1] = v
           hash[v] = true
        else
            if (not hash2[v]) then
                table.insert(dup,v)
                hash2[v] = true
            end
        end
        -- Store overall line count
        tlc = k
    end

    local res_cn = {}

    for x,y in ipairs(dup) do
        local dc = 0
        for z,w in ipairs(buf) do
            if y==w then
                dc = dc+1
                res_cn[y]=dc
            end
        end
        -- Store duplicates line count
        dlc = x
    end

    local unq = tbl_diff(res, dup)

    table.sort(res)
    table.sort(dup)
    table.sort(unq)

    local all_unique   = table.concat(res, "\n")
    local duplicates   = table.concat(dup, "\n")
    local only_unique  = table.concat(unq, "\n")

    if eol then all_unique = all_unique.."\n" end
    if eol then duplicates = duplicates.."\n" end
    if eol then only_unique = only_unique.."\n" end

    print('⚙️ UNIQUE LINES: '..tostring(tlc))
    print('--------------------')
    print(all_unique)
    print('\n⚖ DUPLICATE LINES: '..tostring(dlc))
    print('--------------------------')
    print(duplicates)
    print('~~~~~~~~~~~~~~')
    for key,value in pairsByKeys(res_cn) do
        print(tostring(key) .. "\t\t(" .. tostring(value) .. ")")
    end
    print('\n👍 GENUINELY UNIQUE: '..tostring(tlc-dlc))
    print('----------------------------')
    print(only_unique)
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

line_analysis(args)
