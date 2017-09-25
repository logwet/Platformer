local player = {
  -- Location variables
  x = 16,
  y = 16,

  -- Velocity and acceleration
  xVel = 0,
  yVel = 0,
  acc = 100,

  maxSpeed = 600,
  friction = 20,

  -- Jumping and falling physics
  gravity = 80,
  jumpAcc = 500,
  jumpMaxSpeed = 9.5,
  isJumping = false,
  isGrounded = false,
  hasReachedMax = false,
}

player.init = function (self)
  self.img = love.graphics.newImage("assets/img/player.png") -- Sets sprite image
  self.animGrid = anim8.newGrid(40, 48, self.img:getWidth(), self.img:getHeight()) -- Grid for animations
  self.anim = { -- Define all animations (frames and duration)
    idle = anim8.newAnimation(self.animGrid:getFrames('1-4', 1), 0.08),
    runRight = anim8.newAnimation(self.animGrid:getFrames('1-8', 2), 0.07),
    runLeft = anim8.newAnimation(self.animGrid:getFrames('1-8', 2), 0.07):flipH(),
    jump = anim8.newAnimation(self.animGrid:getFrames('1-9', 3), 0.1),
  }
end

player.update = function(player, dt)
  -- Move Player
  player.goalX = player.x + player.xVel
  player.goalY = player.y + player.yVel
  player.x, player.y, player.collisions, player.len = physics.world:move(player, player.goalX, player.goalY, player.filter)

  -- Adjust velocity with effect of friction
  player.xVel = player.xVel * (1 - math.min(dt * player.friction, 1))
  player.yVel = player.yVel * (1 - math.min(dt * player.friction, 1)) -- The Y-axis does not require friction, but when applied the general feeling and handling is better

  player.yVel = player.yVel + player.gravity * dt -- Apply downward acceleration via gravity

  -- Change velocity of X axis according to key presses
  if love.keyboard.isDown("left", "a") and player.xVel > -player.maxSpeed then
		player.xVel = player.xVel - player.acc * dt
	elseif love.keyboard.isDown("right", "d") and player.xVel < player.maxSpeed then
		player.xVel = player.xVel + player.acc * dt
	end

  -- Jump physics
  if love.keyboard.isDown("up", "w") then
    if -player.yVel < player.jumpMaxSpeed and not player.hasReachedMax then -- If the player is still in the process of jumping
      player.yVel = player.yVel - player.jumpAcc * dt
    elseif math.abs(player.yVel) > player.jumpMaxSpeed then -- The player has reached the jump ceiling
      player.hasReachedMax = true
    end

    player.isGrounded = false
  end

  for i, coll in ipairs(player.collisions) do
    if coll.touch.y > player.goalY then
      player.hasReachedMax = true
      player.isGrounded = false
    elseif coll.normal.y < 0 then
      player.hasReachedMax = false
      player.isGrounded = true
    end
  end
end

player.filter = function(item, other)
  local x, y, w, h = physics.world:getRect(other)
  local px, py, pw, ph = physics.world:getRect(item)
  local playerBottom = py + ph
  local otherBottom = y + h

  if playerBottom <= y then
    return 'slide'
  end
end

--[[player.draw = function (player)
  if love.keyboard.isDown("up", "w") and not (love.keyboard.isDown("left", "a") or love.keyboard.isDown("right", "d")) then
    -- DO something
  end
end]]

return player
