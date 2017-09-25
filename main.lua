-- 3rd Party libraries
class = require "assets.lib.clasp" -- Object orientated programming
anim8 = require "assets.lib.anim8" -- Simple frame based animation
bump = require "assets.lib.bump.bump" -- Collisions (This has a dedicated directory)

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
