--[[
  The Bird class represents our player in the game, with its own state and
  logic for rendering to the screen.
  ]]
Bird = Class {}

-- gravity is a constant, acceleration in the Y axis
local GRAVITY = 20



--[[
  The init function on our class is called just once, when the object is first
  created. Used to set up all variables in the class and get it ready for use.
  ]]
function Bird:init()
  -- load bird image from disk and assign its width and height
  self.image = love.graphics.newImage('images/bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  -- position bird in the middle of the screen
  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

  -- velocity in Y axis
  self.dy = 0
end

--[[
  Called each frame, passing in `dt` since the last frame. `dt` is short for
  `deltaTime` and is measured in seconds. Multiplying this by any changes we wish
  to make in our game will allow our game to perform consistently across all
  hardware; otherwise, any changes we make will be applied as fast as possible
  and will vary across system hardware.
  ]]
function Bird:update(dt)
  -- apply gravity to velocity
  self.dy = self.dy + GRAVITY * dt

  -- apply current velocity to Y position
  self.y = self.y + self.dy
end

--[[
  Called when we want to render the bird to the screen.
  Simply draws the bird in the center of the screen.
  ]]
function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end
