--[[
  Used to represent a pair of pipes that stick together as they scroll, providing an opening
  for the player to jump through in order to score a point.
]]

PipePair = Class {}

-- size of the gap between pipes
GAP_HEIGHT = 100

--[[
  The init function on our class is called just once, when the object is first
  created. Used to set up all variables in the class and get it ready for use.
]]
function PipePair:init(y)
  -- initialize pipes past the end of the screen
  self.x = VIRTUAL_WIDTH + 32

  -- y value is for the topmost pipe; gap is a vertical shift of the second lower pipe
  self.y = y

  -- instantiate two pipes that belong to this pair
  self.pipes = {
    ['upper'] = Pipe('top', self.y),
    ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)
  }

  -- whether this pipe pair is ready to be removed from the scene
  self.remove = false

  -- whether or not this pair of pipes has been scored
  self.scored = false
end

--[[
  PipesPair simply needs to update the two pipes that it contains
]]
function PipePair:update(dt)
  -- remove the pipe from the scene if it's beyond the left edge of the screen,
  -- else move it from right to left
  if self.x > -PIPE_WIDTH then
    self.x = self.x - PIPE_SPEED * dt
    self.pipes['lower'].x = self.x
    self.pipes['upper'].x = self.x
  else
    self.remove = true
  end
end

--[[
  Render both the pipes within this PipesPair
]]
function PipePair:render()
  for _, pipe in pairs(self.pipes) do
    pipe:render()
  end
end
