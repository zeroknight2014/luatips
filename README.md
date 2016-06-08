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


# 2016/5/18 lua中异常处理
--1.捕获异常，使用pcall函数，返回值：第一个为true/false; 第二个为错误信息
```lua
function run()
   -- run code
end

--形式1
local result, error_return = pcall(run);
--形式2，采用匿名函数方式
local result, error_return = pcall(function () return run(); end);
```

--2.捕获异常，使用xpcall(f, err)函数
--参数：1为要运行的保护函数; 2为错误信息处理函数
--返回值：1为true/false; 2为err参数对应函数的返回值
```lua
function run()
   -- run code
   error({})
end

function err_handle(code)
   -- deal error code 
end

local result, err_return = xpcall(run, err_handle);
```

--主动抛出异常，使用error()函数，error的参数为抛出的错误内容，可以是table
```lua
error("run failed.");
error({code=911});
...
print(error_return.code) --911
```

# 2016/5/19 lua中的抽象和继承
lua中没有类的概念，但是有别的方式实现抽象和继承
### 抽象，封装对象，包括属性和方法，使用table来实现
原理：函数是lua中的一等公民，可以和值一样进行赋值，传递
```lua
local people = {
sex = "",
name = "";
};

function people.sleep()  --等同于 people.sleep = function () ... end;
end

function people.eat()
end

function people.work()
end

function people.play()
end
...
```

### 继承，方法的继承和重写
实现原理：在table中查找对应的键值，若不存在，就到table对应的元表中的__index值对应的去表中去查找对应的键值，找到了就返回
```lua
--定义原型
local people = {}

--定义类对象的创建方法
function people:new(o)
  o = o or {};
  setmetatable(o, self); --将people设置为实例对象的元表
  self.__index = self;   --将people的__index指向people自己
  return o;
end

--man可以看作是people的一个实例对象
--也可以看做是man类的原型，继承自people
local man = people:new();

--重写people的play函数
function man:play()
end

```


# 2016/06/08 lua中的table转json
一个函数简单搞定
```lua
function tableToJson(t)
  local function transform(tmp)
    local tb = {}
    for k, v in pairs(tmp) do
      local k_type = type(k)
      local v_type = type(v)
      local key = (k_type == "string" and '"' .. k .. '":') or (k_type == "number" and "")
      local value = (v_type == "table" and transform(v))
          or (v_type == "string" and '"' .. v .. '"')
          or (v_type == "boolean" and tostring(v))
          or (v_type == "number" and v)

      tb[#tb + 1] =  tostring(key) .. tostring(value)
    end
    if table.maxn(tmp) == 0 then
      return "{" .. table.concat(tb, ',') .. "}"
    else
      return "[" .. table.concat(tb, ',') .. "]"
    end
  end

  if t == nil then
    return nil
  end
  return transform(t)
end
```