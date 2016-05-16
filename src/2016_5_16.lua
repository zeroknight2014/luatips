--
-- Created by IntelliJ IDEA.
-- User: zeroknight
-- Date: 2016/5/16
-- Time: 16:58
--

t = {
  "1",
  "2",
  "4",
  "6",
  [8] = "8",
  ["10"] = "10",
  ["2"] = "22"
}

print(#t)
print(table.maxn(t))
local function getlenth(t)
  local count = 0
  for k, v in pairs(t) do
    count = count + 1
  end
  return count
end
print(getlenth(t))

print("----1---")
for k, v in pairs(t) do
  print(k, v)
end

print("----2---")
for k, v in ipairs(t) do
  print(k, v)
end

print("----3---")
for i=1, #t do
  print(i, t[i])
end

print("----4---")
for i=1, table.maxn(t) do
  print(i, t[i])
end

print("----5---")
table.foreach(t, function(i, v) print(i, v) end)

print("----6---")
table.foreachi(t, function(i, v) print(i, v) end)