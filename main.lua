--[[
  push is a library that will allow us to draw our game at a virtual
  resolution, instead of however large our window is; used to provide
  a more retro aesthetic

  https://github.com/Ulydev/push
]]
local push = require 'push'

--[[
  class is a library we're using that will allow us to represent anything in our
  game as code, rather than keeping track of many disparate variables and methods

  https://github.com/vrld/hump/blob/master/class.lua
]]
Class = require 'class'

--[[
  Bird is our class for our flappy bird, which stores position and dimensions for
  the bird and the sprite sheet we'll be rendering to the screen to represent it.
]]
require 'Bird'

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- actual window dimensions
local WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()

-- background image and starting scroll location (X axis)
local background = love.graphics.newImage('images/background.png')
local backgroundScroll = 0

-- ground image and starting scroll location (X axis)
local ground = love.graphics.newImage('images/ground.png')
local groundScroll = 0

-- speed at which we should scroll our images, scaled by dt
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

-- point at which we should loop our background back to X 0
local BACKGROUND_LOOPING_POINT = 413

-- our bird sprite
local bird = Bird()

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

  -- initialize input table
  love.keyboard.keysPressed = {}
end

--[[
  Called by LÖVE whenever we resize the screen; here, we just want to pass in the
  width and height to push so our virtual resolution can be resized as needed.
  @param w The new width.
  @param h The new height.
]]
function love.resize(w, h)
  -- pass in the width and height to push so our virtual resolution can be resized as needed
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
  -- add to our table of keys pressed this frame
  love.keyboard.keysPressed[key] = true
  if key == 'escape' then
    -- function LÖVE gives us to terminate the application
    love.event.quit()
  end
end

--[[
  Check our global input table for keys we activated during
  this frame, looked up by their string value.
]]
function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

--[[
  Called every frame by LÖVE; dt will be elapsed time in seconds since the last frame,
  and is passed into update dt.
]]
function love.update(dt)
  -- scroll our background and ground, looping back to 0 after a certain amount
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

  -- update our bird based on its own update logic
  bird:update(dt)

  -- reset input table
  love.keyboard.keysPressed = {}
end

--[[
  Called after update by LÖVE2D, used to draw anything to the screen, updated or otherwise.
]]
function love.draw()
  -- start rendering at virtual resolution
  push:start()

  -- draw the background starting at top left (0, 0)
  love.graphics.draw(background, -backgroundScroll, 0)

  -- draw the ground on top of the background, toward the bottom of the screen
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

  -- render our bird to the screen using its own render logic
  bird:render()

  -- finish rendering at virtual resolution
  push:finish()
end
