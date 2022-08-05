local proxy = newproxy(true)
local mt = getmetatable(proxy)

local function createEnvironment (new_env)
  local sgame = require(script.game)(new_env)

  return {
    game = sgame
  }
end

local function sandbox(code, options)
  local loadstring = loadstring
  local new_env
  local environment
  if options then
    loadstring = options.customloadstring or loadstring
    new_env = options.new_env or true
    environment = options.env or createEnvironment(new_env)
  end

  if not game:GetService("RunService"):IsServer() and (not options or not options.customloadstring) then
    error("Loadstring cannot be accessed from the client unless you have specified a custom loadstring module")
  elseif not typeof(loadstring) == 'function' then
    error("Loadstring is not of type function if you are using a module you must require the module first")
  end

  local func

  local success, err = pcall(function()
    func = loadstring(code)
  end)

  if success then
    setfenv(func, environment)
  else
    error("Loadstring failed to execute\n"..err)
  end
end

mt.__index = function (self, index)
  if index == 'sandbox' then
    return sandbox
  end
end

mt.__metatable = 'Locked!'

return proxy