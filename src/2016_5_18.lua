--
-- Created by IntelliJ IDEA.
-- User: zeroknight
-- Date: 2016/5/18
-- Time: 10:27
--

function run()
  print("run start!")
  print(hehe.."")
end

function err_handle(code)
  return code.." \nyour code runs failed."
end

local result, error_re = pcall(run)
print(result)
print(error_re)

local result, error_re = pcall(function () return run() end)
print(result)
print(error_re)

local result, error_re = xpcall(run, err_handle)
print(result)
print(error_re)



