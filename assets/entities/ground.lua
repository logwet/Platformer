local Class = require "assets.lib.hump.class"
local Entity = require "assets.entities.Entity"

local Ground = Class{
  __includes = Entity -- The Ground class willl inherit the Entity class
}

function Ground:init(world, x, y, w, h)
  Entity.init(self, world, x, y, w, h)
  self.world:add(self, self.getRect())
end

function Ground:draw()
  love.graphics.rectangle('fill', self:getRect())
end

return Ground
