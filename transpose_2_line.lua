-- 🚀 [Check if selected item numeric]
function is_numeric(x)
    if tonumber(x) ~= nil then
        return true
    end
    return false
end

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



-- 🚀 [TRANSPOSE TO LINE FOR SQL]
function transpose_2_line(sel)
    local hash = {}
    local res = {}

    local eol = string.match(sel, "\n$")
    local buf = lines(sel)

    for _,v in ipairs(buf) do
        if (not hash[v]) then
            -- Recognize numbers
            if is_numeric(v) then
                res[#res+1] = v
            else
                ch_s  = v:sub(1,1)
                ch_e  = v:sub(-1,-1)
                str_m = v:sub(2,v:len()-1)

                local str_res = ''
                local cn = 0

                for i = 2, v:len()-1, 1 do
                    if v:sub(i,i) == "'" then
                        if cn == 0 then
                            str_res = str_res..v:sub(i,i)
                        end
                        cn = cn + 1
                    else
                        cn = 0
                        str_res = str_res..v:sub(i,i)
                    end
                end

                str_r = string.gsub(str_res,"'","''")

                if ch_s == "'" then
                    if ch_e == "'" then
                        res[#res+1] = ch_s..str_r..ch_e
                    else
                        res[#res+1] = ch_s..str_r..ch_e.."'"
                    end
                else
                    if ch_e == "'" then
                        res[#res+1] = "'"..ch_s..str_r..ch_e
                    else
                        res[#res+1] = "'"..ch_s..str_r..ch_e.."'"
                    end
                end
            end

            hash[v] = true
        end
    end

    local out = table.concat(res, ", ")
    if eol then out = out.."\n" end
    return (out)
end

print(transpose_2_line(arg[1]))