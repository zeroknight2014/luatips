发现有很多人搞了个xxxtips，所以就也搞一个lua的。
随便写写，记录一下知识点。


# 2016/5/14 lua函数的变参用法

使用...代表多个参数
>function test(...)

使用select获取参数，当arg为#时，返回参数个数；当arg为int时，返回对应的参数
>result = select(arg, ...)



# 2016/5/16 lua中table的遍历
```lua
t = {
  "1",
  "2",
  "4",
  "6",
  [8] = "8",
  ["10"] = "10",
  ["2"] = "22"
}
```

### table长度计算
--这种计算要求table中的key必须是整型，且key是从1开始，且必须是连续的，一旦中断，后面的不再计算
```lua 
print(#t) 
```
    
--这种方式计算出来的是table中整型key的最大值
```lua 
print(table.maxn(t))
```

--最好的方式计算table长度
```lua
local function getlenth(t)
  local count = 0
  for k, v in pairs(t) do
    count = count + 1
  end
  return count
end
print(getlenth(t))
```

### table的循环遍历
--pairs函数会循环读取table的所有值
```lua
for k, v in pairs(t) do
  print(k, v)
end
```

--ipairs只会从key为1开始，读取连续的整型key对应的值，不连续时就会终止
```lua 
for k, v in ipairs(t) do
  print(k, v)
end
```

--这种方式读取的结果类似ipairs, 参见#获取table长度的原理
```lua
for i=1, #t do
  print(i, t[i])
end
```

--这种方式参见table.maxn获取的返回值，不推荐使用
```lua
for i=1, table.maxn(t) do
  print(i, t[i])
end
```

--该形式类似于pairs
```lua
table.foreach(t, function(i, v) print(i, v) end)
```

--该形式类似于ipairs
```lua
table.foreachi(t, function(i, v) print(i, v) end)
```