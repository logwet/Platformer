local Class = require "libs.hump.class"
local Entity = require "entities.Entity"
--local anim8 = require "libs.anim8.anim8"

local player = Class{__includes = Entity}

function player:init(world, x, y)
  self.img = love.graphics.newImage('assets/img/player.png')
  Entity.init(self, world, x, y, self.img:getWidth(), self.img:getHeight())

  --Attributes:
  self.xVel = 0
  self.yVel = 0
  self.acc = 100 -- Acceleration
  self.maxSpeed = 600
  self.friction = 20
  self.gravity = 100
  --Jumping
  self.isJumping = false
  self.isGrounded = false
  self.hasReachedMax = false
  self.jumpAcc = 500
  self.jumpMaxSpeed = 11

  self.world:add(self, self:getRect())
end

function player:collisionFilter(other)
  local x, y, w, h = self.world:getRect(other)
  local playerBottom = self.y + self.h
  local otherBottom = y + h

  if playerBottom <= y then -- bottom of player collides with top of platform.
    return 'slide'
  end
end

function player:update(dt)
  local prevX, prevY = self.x, self.y

  -- Apply friction
  self.xVel = self.xVel * (1 - math.min(dt * self.friction, 1)) -- Math.min chooses the smaller value of friction multiplied by delta time and the int 1
  self.yVel = self.yVel * (1 - math.min(dt * self.friction, 1)) -- In reality the horizontal axis has little friction but adding it does add realism

  -- Apply gravity
  self.yVel = self.yVel + self.gravity * dt -- Delta Time (dt) is the amount of time between the previous frame and the present one. Using this normalises values on different computers with different frame rates.

  if love.keyboard.isDown("left", "a") and self.xVel > -self.maxSpeed then
		self.xVel = self.xVel - self.acc * dt
	elseif love.keyboard.isDown("right", "d") and self.xVel < self.maxSpeed then
		self.xVel = self.xVel + self.acc * dt
	end

  -- Jump code
  if love.keyboard.isDown("up", "w") then
    if -self.yVel < self.jumpMaxSpeed and not self.hasReachedMax then
      self.yVel = self.yVel - self.jumpAcc * dt
    elseif math.abs(self.yVel) > self.jumpMaxSpeed then
      self.hasReachedMax = true
    end
    self.isGrounded = false -- Player is no longer in contact with the ground
  end

  -- The location that the player is attempting to reach
  local goalX = self.x + self.xVel
  local goalY = self.y + self.yVel

  -- Move the player while testing for collisions
  self.x, self.y, collisions, len = self.world:move(self, goalX, goalY, self.collisionFilter)

  -- Parse through collisions to check for special events
  for i, coll in ipairs(collisions) do
    if coll.touch.y > goalY then
      self.hasReachedMax = true
      self.isGrounded = false
    elseif coll.normal.y < 0 then
      self.hasReachedMax = false
      self.isGrounded = true
    end
  end
end

function player:draw()
  love.graphics.draw(self.img, self.x, self.y)
end

--21x21, 2 border
return player
