--[[
  push is a library that will allow us to draw our game at a virtual
  resolution, instead of however large our window is; used to provide
  a more retro aesthetic

  https://github.com/Ulydev/push
]]
local push = require 'push'

-- virtual resolution dimensions
local VIRTUAL_WIDTH = 512
local VIRTUAL_HEIGHT = 288

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
  Called every frame by LÖVE; dt will be elapsed time in seconds since the last frame,
  and is passed into update dt.
]]
function love.update(dt)
  -- scroll our background and ground, looping back to 0 after a certain amount
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
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

  -- finish rendering at virtual resolution
  push:finish()
end
