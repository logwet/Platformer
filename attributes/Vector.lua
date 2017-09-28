local Class = require "libs.hump.class"

local Vector = Class{
  init = function(self, x, y)
    self.x = x
    self.y = y
  end,
}

return Vector
