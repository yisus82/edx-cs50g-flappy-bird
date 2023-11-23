--[[
  The Bird class represents our player in the game, with its own state and
  logic for rendering to the screen.
  ]]
Bird = Class {}

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
end

--[[
  Called when we want to render the bird to the screen.
  Simply draws the bird in the center of the screen.
  ]]
function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end
