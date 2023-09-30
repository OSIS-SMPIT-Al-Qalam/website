local lapis = require("lapis")
local app = lapis.Application()

app:get("/", function()
  return "Hello World!"
end)

return app
