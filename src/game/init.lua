local function createProxy()
  local proxy = newproxy(true)
  local mt = getmetatable(proxy)

  return proxy
end

local cachedProxy

return function (new_env)
  if new_env or not cachedProxy then
    local proxy = createProxy()

    cachedProxy = proxy

    return proxy
  else
    return cachedProxy
  end
end