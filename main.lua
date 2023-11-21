--[[
  push is a library that will allow us to draw our game at a virtual
  resolution, instead of however large our window is; used to provide
  a more retro aesthetic

  https://github.com/Ulydev/push
]]
local push = require 'push'

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- actual window dimensions
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()

-- images we load into memory from files to later draw onto the screen
local background = love.graphics.newImage('images/background.png')
local ground = love.graphics.newImage('images/ground.png')

--[[
  Called exactly once at the beginning of the game; used to initialize the game.
]]
function love.load()
  -- initialize our nearest-neighbor filter
  love.graphics.setDefaultFilter('nearest', 'nearest')

  -- app window title
  love.window.setTitle('Flappy Bird')

  -- initialize our virtual resolution
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
  })
end

--[[
  Called by LÖVE whenever we resize the screen; here, we just want to pass in the
  width and height to push so our virtual resolution can be resized as needed.
  @param w The new width.
  @param h The new height.
]]
function love.resize(w, h)
  push:resize(w, h)
end

--[[
  Called whenever a key is pressed.
  @param key The key that was pressed.
  @param scancode The scancode of the key that was pressed.
  @param isrepeat Whether this keypress event is a repeat. The delay between key repeats
  depends on the user's system settings.
]]
function love.keypressed(key, _scancode, _isrepeat)
  if key == 'escape' then
    love.event.quit()
  end
end

--[[
  Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
  -- begin rendering at virtual resolution
  push:apply('start')

  -- draw the background starting at top left (0, 0)
  love.graphics.draw(background, 0, 0)

  -- draw the ground on top of the background, toward the bottom of the screen
  love.graphics.draw(ground, 0, VIRTUAL_HEIGHT - 16)

  -- end rendering at virtual resolution
  push:apply('end')
end
