--[[
  The Pipe class represents the pipes that randomly spawn in our game, which act as our primary obstacles.
  The pipes can stick out a random distance from the top or bottom of the screen. When the player collides
  with one of them, it's game over. Rather than our bird actually moving through the screen horizontally,
  the pipes themselves scroll through the game to give the illusion of player movement.
]]

Pipe = Class {}

-- since we only want the image loaded once, not per instantation, define it externally
local PIPE_IMAGE = love.graphics.newImage('images/pipe.png')

-- speed at which the pipe should scroll right to left
PIPE_SPEED = 60

-- height of pipe image, globally accessible
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

--[[
  Pipe:init is called only once, when the pipe pair is created at the start of the level.
  It serves as our constructor, initializing each pipe object with the given parameters.
]]
function Pipe:init(orientation, y)
  self.x = VIRTUAL_WIDTH
  self.y = y
  self.width = PIPE_IMAGE:getWidth()
  self.height = PIPE_HEIGHT
  self.orientation = orientation
end

--[[
  Renders the pipe by drawing the image at its position.
]]
function Pipe:render()
  -- draw the pipe with the correct orientation and position
  love.graphics.draw(PIPE_IMAGE, self.x,
    (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y),
    0, 1, self.orientation == 'top' and -1 or 1)
end
