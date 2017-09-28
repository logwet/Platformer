-- Import libraries
bump = require "libs.bump.bump"
Gamestate = require "libs.hump.gamestate"

-- Entity system
local Entities = require "entities.Entities"
local Entity = require "entities.Entity"

-- Init Gamestate
local gameLevel1 = Gamestate.new()

-- Import Entities
local Player = require "entities.player"
local Ground = require "entities.Ground"

-- Important variables
--player = nil
--world = nil

function gameLevel1:enter()
  -- Collisions
  world = bump.newWorld(16)

  -- Init Entity system
  Entities:enter()
  player = Player(world, 16, 16)
  ground_0 = Ground(world, 120, 360, 640, 16)
  ground_1 = Ground(world, 0, 448, 640, 16)

  -- Add instances of entities to the list
  Entities:addMany({player, ground_0, ground_1})
end

function gameLevel1:update(dt)
  Entities:update(dt)
end

function gameLevel1:draw()
  Entities:draw()
end

return gameLevel1
