--
-- Created by IntelliJ IDEA.
-- User: zeroknight
-- Date: 2016/5/23
-- Time: 17:13
-- To change this template use File | Settings | File Templates.
--

local test_tb = {
  apps = {
    app1 = {
      pkg = "com.baidu",
      code = 100,
      version = "120",
      isPay = true,
      other = ""
    },
    app2 = {
      pkg = "com.tencent",
      code = 0,
      version = "1.1.1",
      isPay = false,
      other = nil
    }
  },
  id = "12321",
  channel = {
    "baidu", "huawei", "oppo"
  }
}


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

print(tableToJson(test_tb))












local result_json = [[
{
  "apps": {
    "app1": {
      "pkg": "com.baidu",
      "code": 100,
      "version": "120",
      "isPay": true,
      "other": "",
    },
    "app2": {
      "pkg": "com.tencent",
      "code": 0,
      "version": "1.1.1",
      "isPay": true,
      "other": ,
    },
  },
  "id": "12321",
  "channel": ["baidu", "huawei", "oppo"]
}
]]
