local physics = {
  world = nil,
  objects = {
    ground_0 = {},
    ground_1 = {},
  },
}

physics.init = function (self)
  self.world = bump.newWorld(64)
  self.world:add(player, player.x, player.y, player.img:getWidth(), player.img:getHeight())
  self.world:add(self.objects.ground_0, 120, 360, 640, 16)
  self.world:add(self.objects.ground_1, 0, 448, 640, 32)
end

physics.draw = function (physics)
  love.graphics.rectangle('fill', physics.world:getRect(physics.objects.ground_0))
  love.graphics.rectangle('fill', physics.world:getRect(physics.objects.ground_1))
end

return physics
