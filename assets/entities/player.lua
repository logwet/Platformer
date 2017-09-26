local Class = require "assets.lib.hump.class"
local Entity = require 'assets.entities.Entity'

local player = Class{
  __includes = Entity -- Inherits from entity Class
}

function player:init(world, x, y)
  self.img = love.graphics.newImage("assets/img/player.png")
  Entity.init(self, world, x, y, self.img:getWidth(), self.img:getHeight())

  -- Unique Player variables:
  self.xVel = 0
  self.yVel = 0
  self.acc = 100
  self.maxSpeed = 600
  self.friction = 20
  self.gravity = 80
  --Jumping:
  self.isJumping = false
  self.isGrounded = false
  self.hasReachedMax = false
  self.jumpAcc = 500
  self.jumpMaxSpeed = 11

  -- Animations:
  self.animGrid = anim8.newGrid(40, 48, self.img:getWidth(), self.img:getHeight())
  self.anim = { -- Define all animations (frames and duration)
    idle = anim8.newAnimation(self.animGrid:getFrames('1-4', 1), 0.08),
    runRight = anim8.newAnimation(self.animGrid:getFrames('1-8', 2), 0.07),
    runLeft = anim8.newAnimation(self.animGrid:getFrames('1-8', 2), 0.07):flipH(),
    jump = anim8.newAnimation(self.animGrid:getFrames('1-9', 3), 0.1),
  }

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

  -- Adjust velocity with effect of friction
  self.xVel = self.xVel * (1 - math.min(dt * self.friction, 1))
  self.yVel = self.yVel * (1 - math.min(dt * self.friction, 1))

  -- Apply downwards gravity
  player.yVel = player.yVel + player.gravity * dt

  -- Change x-axis velocity according to key presses
  if love.keyboard.isDown("left", "a") and self.xVel > -self.maxSpeed then
		self.xVel = self.xVel - self.acc * dt
    self.anim.runLeft:update(dt)
	elseif love.keyboard.isDown("right", "d") and self.xVel < self.maxSpeed then
		self.xVel = self.xVel + self.acc * dt
    self.anim.runRight:update(dt)
	end

  -- Jump code
  if love.keyboard.isDown("up", "w") then
    if -self.yVel < self.jumpMaxSpeed and not self.hasReachedMax then
      self.yVel = self.yVel - self.jumpAcc * dt
      self.anim.idle:update(dt)
    elseif math.abs(self.yVel) > self.jumpMaxSpeed then
      self.hasReachedMax = true
    end
    self.isGrounded = false -- Player is no longer in contact with the ground
  end

  -- Where the player's desired location is
  local goalX = self.x + self.xVel
  local goalY = self.y + self.yVel

  -- Actually move the player while checking for collisions and filtering at the same time
  self.x, self.y, collisions, len = self.world:move(self, goalX, goalY, self.collisionFilter)

  -- Iterate through collisions and provide exceptions for events
  for i, coll in ipairs(collisions) do
    if coll.touch.y > goalY then
      self.hasReachedMax = true
      self.isGrounded = false
    elseif coll.normal.y < 0 then
      self.hasReachedMax = false
      self.isGrounded = true
    end
  end
  self.anim.idle:update(dt)
end

function player:draw()
  love.graphics.draw(self.img, self.x, self.y)
  if love.keyboard.isDown("left", "a") and self.xVel > -self.maxSpeed then
    self.anim.runLeft:draw(self.img, self.x, self.y)
	elseif love.keyboard.isDown("right", "d") and self.xVel < self.maxSpeed then
    self.anim.runRight:draw(self.img, self.x, self.y)
	elseif -self.yVel < self.jumpMaxSpeed and not self.hasReachedMax then
    self.anim.idle:draw(self.img, self.x, self.y)
  end
end

return player
