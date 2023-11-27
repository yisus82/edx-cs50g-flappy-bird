--[[
  The Pipe class represents the pipes that randomly spawn in our game, which act as our primary obstacles.
  The pipes can stick out a random distance from the top or bottom of the screen. When the player collides
  with one of them, it's game over. Rather than our bird actually moving through the screen horizontally,
  the pipes themselves scroll through the game to give the illusion of player movement.
]]

Pipe = Class {}

-- since we only want the image loaded once, not per instantation, define it externally
local PIPE_IMAGE = love.graphics.newImage('images/pipe.png')

-- pipe scrolling speed; negative value representing scroll from right to left
local PIPE_SCROLL = -60

--[[
  The init function on our class is called just once, when the object is first
  created. Used to set up all variables in the class and get it ready for use.
  ]]
function Pipe:init()
  -- set the pipe's X to the right of the screen
  self.x = VIRTUAL_WIDTH

  -- set the Y to a random value halfway below the screen
  self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)

  -- set the pipe's width as the width of the image used
  self.width = PIPE_IMAGE:getWidth()
end

--[[
  Called each frame, passing in `dt` since the last frame. `dt` is short for
  `deltaTime` and is measured in seconds. Multiplying this by any changes we wish
  to make in our game will allow our game to perform consistently across all
  hardware; otherwise, any changes we make will be applied as fast as possible
  and will vary across system hardware.
  ]]
function Pipe:update(dt)
  -- scroll the pipe leftward by decrementing X by scroll speed times delta time
  self.x = self.x + PIPE_SCROLL * dt
end

--[[
  Renders the pipe by drawing the image at its position.
  ]]
function Pipe:render()
  -- draw the pipe at the bottom of the screen, inset by its width so it's centered
  love.graphics.draw(PIPE_IMAGE, math.floor(self.x + 0.5), math.floor(self.y))
end
