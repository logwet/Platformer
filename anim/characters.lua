local Class = require "libs.hump.class"
local anim8 = require "libs.anim8.anim8"
local animCharacters = Class{}

function animCharacters:init()
  self.img = love.graphics.newImage('assets/img/characters.png')
  self.grid = anim8.newGrid(32, 32, self.img:getWidth(), self.img:getHeight(), 0, 0, 0)
  self.anim = {
    golem = {
      idleLeft = anim8.newAnimation(self.grid:getFrames(1,1), 0.1):flipH(),
      idleRight = anim8.newAnimation(self.grid:getFrames(1,1), 0.1),
      walkLeft = anim8.newAnimation(self.grid:getFrames('1-4',1), 0.1):flipH(),
      walkRight = anim8.newAnimation(self.grid:getFrames('1-4',1), 0.1),
      jump = {
        prep = anim8.newAnimation(self.grid:getFrames(5,1),1),
        mvUp = anim8.newAnimation(self.grid:getFrames(6,1),1),
        mvDn = anim8.newAnimation(self.grid:getFrames(7,1),1),
        land = anim8.newAnimation(self.grid:getFrames(8,1),1),
      },
      runLeft = anim8.newAnimation(self.grid:getFrames('15-18',1), 0.1):flipH(),
      runRight = anim8.newAnimation(self.grid:getFrames('15-18',1), 0.1),
    },
    king = {
      walkLeft = anim8.newAnimation(self.grid:getFrames('1-4',2), 0.1):flipH(),
      walkRight = anim8.newAnimation(self.grid:getFrames('1-4',2), 0.1),
      jump = {
        prep = anim8.newAnimation(self.grid:getFrames(5,1),2),
        mvUp = anim8.newAnimation(self.grid:getFrames(6,1),2),
        mvDn = anim8.newAnimation(self.grid:getFrames(7,1),2),
        land = anim8.newAnimation(self.grid:getFrames(8,1),2),
      },
      runLeft = anim8.newAnimation(self.grid:getFrames('15-18',2), 0.1):flipH(),
      runRight = anim8.newAnimation(self.grid:getFrames('15-18',2), 0.1),
    },
    elf = {
      walkLeft = anim8.newAnimation(self.grid:getFrames('1-4',3), 0.1):flipH(),
      walkRight = anim8.newAnimation(self.grid:getFrames('1-4',3), 0.1),
      jump = {
        prep = anim8.newAnimation(self.grid:getFrames(5,1),3),
        mvUp = anim8.newAnimation(self.grid:getFrames(6,1),3),
        mvDn = anim8.newAnimation(self.grid:getFrames(7,1),3),
        land = anim8.newAnimation(self.grid:getFrames(8,1),3),
      },
      runLeft = anim8.newAnimation(self.grid:getFrames('15-18',3), 0.1):flipH(),
      runRight = anim8.newAnimation(self.grid:getFrames('15-18',3), 0.1),
    },
    snake = {
      idleLeft = anim8.newAnimation(self.grid:getFrames('1-4',4), 0.3):flipH(),
      idleRight = anim8.newAnimation(self.grid:getFrames('1-4',4), 0.3),
    },
  }
end

function animCharacters:update()

end

function animCharacters:draw()

end

return animCharacters
