local Object = Object or require "object"
local GameStateController = Object:extend()

function GameStateController:new()
  self.isPlaying = false
  self.isStandBy = false
  self.isGameOver = false
end
function GameStateController:update(dt)
  if(playerScore.score >= data.gameLimit or cpuScore.score >= data.gameLimit) then
    self.isGameOver = true
    end
end
function GameStateController:draw()
end
return GameStateController