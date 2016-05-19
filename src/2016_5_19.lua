--
-- Created by IntelliJ IDEA.
-- User: zeroknight
-- Date: 2016/5/19
-- Time: 17:24
--

--一个原型
people = {
  sex = "",
  name = ""
};

--实例的创建方法
function people:new(o)
  local o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

--原型的方法
function people:sleep()
  print("people sleep.");
end

function people:eat()
  print("people eat.");
end

function people:work()
  print("people work.");
end

function people:play()
  print("people play.");
end

--原型的实例化
local people1 = people:new();

people1:sleep();
people1:play();

--继承
local man = people:new();

function man:new(o)
  local o = o or {};
  setmetatable(o, self);
  self.__index = self;
  return o;
end

--继承后，重写方法
function man:play()
  print("man play.");
end

man:play();
man:work();


--原型的实例化也可以看做是继承的实现
local super = people:new();

--重写方法
function super:work()
  print("super save world.")
end

super:work()
super:eat()


