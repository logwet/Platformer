-- 3rd Party libraries
--class = require "assets.lib.clasp.clasp" -- Object orientated programming
anim8 = require "assets.lib.anim8.anim8" -- Simple frame based animation
bump = require "assets.lib.bump.bump" -- Collisions
Class = require "assets.lib.hump.class"

entity = require "assets.entities.entity"
player = require "assets.script.player"
physics = require "assets.script.physics"

function love.load()
  player.init(player)
  physics.init(physics)

end

function love.update(dt)
  player.anim.idle:update(dt)
  player.update(player, dt)
end

function love.draw(dt)
  player.anim.idle:draw(player.img, player.x, player.y)
  physics.draw(physics)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
end
