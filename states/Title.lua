--[[
  This is the starting screen of the game, shown on startup. It should
  display "Press Enter" and also our highest score.
]]

Title = Class { __includes = Base }

function Title:update(_dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    GameStateMachine:change('Play')
  end
end

function Title:render()
  love.graphics.setFont(FlappyFont)
  love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(MediumFont)
  love.graphics.printf('Press Enter to play', 0, 100, VIRTUAL_WIDTH, 'center')
end
