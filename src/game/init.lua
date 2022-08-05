local function createProxy()
  local proxy = newproxy(true)
  local mt = getmetatable(proxy)

  return proxy
end
