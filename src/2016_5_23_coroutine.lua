--
-- Created by IntelliJ IDEA.
-- User: zeroknight
-- Date: 2016/5/19
-- Time: 15:14
-- To change this template use File | Settings | File Templates.
--

--Lua的协同程序还具有一项有用的机制，就是可以通过一对resume-yield来交换数据。
-- 在第一次调用resume时，并没有对应的yield在等待它，因此所有传递给resume的额外参数都视为协同程序主函数的参数
function foo (a)
  print("foo", a)  -- foo 2
  return coroutine.yield(2 * a) -- return 2 * a
end

co = coroutine.create(function (a , b)
  print("co-body", a, b) -- co-body 1 10
  local r = foo(a + 1)

  print("co-body2", r)
  local r, s = coroutine.yield(a + b, a - b)

  print("co-body3", r, s)
  return b, "end"
end)

print("main", coroutine.resume(co, 1, 10)) -- true, 4
print("------")
print("main", coroutine.resume(co, "r")) -- true 11 -9
print("------")
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("------")
print("main", coroutine.resume(co, "x", "y")) -- false cannot resume dead coroutine
print("------")

-- 使用coroutine演示生产者、消费者问题
local newProductor

function productor()
  local i = 0
  while true do
    i = i + 1
    send(i)     -- 将生产的物品发送给消费者
  end
end

function consumer()
  while true do
    local i = receive()     -- 从生产者那里得到物品
    print(i)
  end
end

function receive()
  local status, value = coroutine.resume(newProductor)
  return value
end

function send(x)
  coroutine.yield(x)     -- x表示需要发送的值，值返回以后，就挂起该协同程序
end

-- 启动程序
newProductor = coroutine.create(productor)
consumer()