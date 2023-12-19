--[[
  Counts down visually on the screen (3, 2, 1) so that the player knows the
  game is about to begin. Transitions to the Play state as soon as the
  countdown is complete.
]]

Countdown = Class { __includes = Base }

-- how long each countdown lasts in seconds
COUNTDOWN_TIME = 0.75

--[[
    We initialize what's in our Countdown state.
]]
function Countdown:init()
  self.count = 3
  self.timer = 0
end

--[[
  Keeps track of how much time has passed and decreases count if the
  timer has exceeded our countdown time. If we have gone down to 0,
  we should transition to our PlayState.
]]
function Countdown:update(dt)
  -- set timer to current time + amount of passed in dt
  self.timer = self.timer + dt

  -- if timer has exceeded our countdown time, we should decrement our counter
  if self.timer > COUNTDOWN_TIME then
    self.timer = self.timer % COUNTDOWN_TIME
    self.count = self.count - 1

    -- when 0 is reached, we should enter the Play state
    if self.count == 0 then
      GameStateMachine:change('Play')
    end
  end
end

--[[
  Simply renders the count number to the middle of the screen.
]]
function Countdown:render()
  love.graphics.setFont(HugeFont)
  love.graphics.printf(tostring(self.count), 0, 120, VIRTUAL_WIDTH, 'center')
end
