--[[
  The Play state is the bulk of the game, where the player actually controls the bird and
  avoids pipes. When the player collides with a pipe, we should go to the GameOver state, where
  we then go back to the main menu.
]]

Play = Class { __includes = Base }

--[[
  Called when the state is first entered; initialize the bird and pipes here.
]]
function Play:init()
  self.bird = Bird()
  self.pipePairs = {}
  self.timer = 0
  self.score = 0
  -- initialize our last recorded Y value for a gap placement to base other gaps off of
  self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

--[[
  Called each time this state is updated; update bird and pipes here.
]]
function Play:update(dt)
  -- update timer for pipe spawning
  self.timer = self.timer + dt

  -- spawn a new pipe pair every second and a half
  if self.timer > 2 then
    -- modify the last Y coordinate we placed so pipe gaps aren't too far apart
    -- no higher than 10 pixels below the top edge of the screen,
    -- and no lower than a gap height from the bottom
    local y = math.max(-PIPE_HEIGHT + 10,
      math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - GAP_HEIGHT - PIPE_HEIGHT))
    self.lastY = y

    -- add a new pipe pair at the end of the screen at our new Y
    table.insert(self.pipePairs, PipePair(y))

    -- reset timer
    self.timer = 0
  end

  -- for every pair of pipes
  for _, pair in pairs(self.pipePairs) do
    -- score a point if the pipe has gone past the bird to the left all the way
    -- be sure to ignore it if it's already been scored
    if not pair.scored then
      if pair.x + PIPE_WIDTH < self.bird.x then
        self.score = self.score + 1
        pair.scored = true
      end
    end

    -- update position of pair
    pair:update(dt)
  end

  -- we need this second loop, rather than deleting in the previous loop, because
  -- modifying the table in-place without explicit keys will result in skipping the
  -- next pipe, since all implicit keys (numerical indices) are automatically shifted
  -- down after a table removal
  for k, pair in pairs(self.pipePairs) do
    if pair.remove then
      table.remove(self.pipePairs, k)
    end
  end

  -- update bird based on gravity and input
  self.bird:update(dt)

  -- simple collision between bird and all pipes in pairs
  for _, pair in pairs(self.pipePairs) do
    for _, pipe in pairs(pair.pipes) do
      if self.bird:collides(pipe) then
        GameStateMachine:change('Score', {
          score = self.score
        })
      end
    end
  end

  -- reset if we get to the ground
  if self.bird.y > VIRTUAL_HEIGHT - 15 then
    GameStateMachine:change('Score', {
      score = self.score
    })
  end
end

--[[
  Render the bird and pipes.
]]
function Play:render()
  -- render the pipes in the scene
  for _, pair in pairs(self.pipePairs) do
    pair:render()
  end

  -- render the score
  love.graphics.setFont(FlappyFont)
  love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

  -- render the high score to the top right
  love.graphics.setFont(FlappyFont)
  love.graphics.print('High Score: ' .. tostring(HighScore), VIRTUAL_WIDTH - 250, 8)

  -- render bird to the screen
  self.bird:render()
end
