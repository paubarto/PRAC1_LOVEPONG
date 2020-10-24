local Object = Object or require "object"
local GameScore = Object:extend()

function GameScore:new(score,x,y)
  self.score = score
  self.x = x
  self.y = y
  self.screenWidth = love.graphics.getWidth()
  end
function GameScore:update(dt)
end
function GameScore:draw()
  love.graphics.print(self.score,self.x,self.y)
  self:checkColors()
end
function GameScore:increaseScore()
  self.score = self.score + 1
end
function GameScore:checkColors()
   if(playerScore.score < cpuScore.score) then 
   love.graphics.setColor(unpack(data.redColor))
   love.graphics.print(playerScore.score,playerScore.x, self.y)--self.screenWidth/3, self.y,0)
   love.graphics.setColor(unpack(data.greenColor))
   love.graphics.print(cpuScore.score,cpuScore.x,self.y)-- - self.screenWidth/3, self.y, 0)
 end
  if(playerScore.score > cpuScore.score) then
   love.graphics.setColor(unpack(data.greenColor))
   love.graphics.print(playerScore.score,playerScore.x,self.y)--self.screenWidth/3, self.y,0)
   love.graphics.setColor(unpack(data.redColor))
   love.graphics.print(cpuScore.score,cpuScore.x, self.y)
 end
  end
return GameScore
  