--
-- Created by IntelliJ IDEA.
-- User: zeroknight
-- Date: 2016/5/14
-- Time: 18:22
-- To change this template use File | Settings | File Templates.
--

--lua中函数的变参用法

function test(...)
  local argc = select('#', ...)
  print("argc: ", argc)
  for i = 1, argc do
    local argv = select(i, ...)
    print(i, ": ", argv)
  end
end

test("lua", "lua2", "lua3", "lua4")