--[[
  A simple state used to display the player's score before they
  transition back into the play state. Transitioned to from the
  Play state when they collide with a Pipe.
]]

Score = Class { __includes = Base }

local highScore = 0

--[[
  When we enter the score state, we expect to receive the score
  from the play state so we know what to render to the screen.
]]
function Score:enter(params)
  self.score = params.score
  highScore = math.max(self.score, highScore)
end

--[[
  Goes into the play state if enter is pressed.
]]
function Score:update(_dt)
  -- go back to play if enter is pressed
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    GameStateMachine:change('Play', {
      highScore = highScore
    })
  end
end

--[[
  Renders the score and instructions to play again to the screen.
]]
function Score:render()
  -- render a lost message
  love.graphics.setFont(FlappyFont)
  love.graphics.printf('Oh, no! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

  -- render the score to the middle of the screen
  love.graphics.setFont(MediumFont)
  love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

  -- render the high score to the middle of the screen
  love.graphics.printf('High Score: ' .. tostring(highScore), 0, 116, VIRTUAL_WIDTH, 'center')

  -- render instructions on how to play again
  love.graphics.printf('Press Enter to play again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
