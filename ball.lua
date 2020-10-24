local Object = Object or require "object"
local Ball = Object:extend()

function Ball:new(x,y,ballRadius,ballAngle,ballSpeed,foto)
  self.x = x
  self.y = y
  self.ballRadius = ballRadius
  self.ballAngle = ballAngle
  self.ballSpeed = ballSpeed
  self.foto = foto
end
function Ball:update(dt)
  self.x = self.x + math.cos(math.rad(self.ballAngle)) * self.ballSpeed * dt
  self.y = self.y + math.sin(math.rad(self.ballAngle)) * self.ballSpeed * dt
end
function Ball:draw()
  --love.graphics.circle("fill",self.x,self.y,self.ballRadius)
   love.graphics.draw(self.foto,self.x,self.y,data.bTextureRotation,data.bTextureScale,data.bTextureScale)
end
 function Ball:checkTopBottomCollision(h)
    --Top screen:
    if (self.y < data.screenTopBallLimit) then
      --Rebotar cap abaix esq 
        love.audio.play(wallSFX)
        self.ballAngle = data.wallBounceAngle - self.ballAngle
    end
    --Bottom screen:
    if(data.screenBottomBallLimit < self.y) then
        love.audio.play(wallSFX)
        self.ballAngle = data.wallBounceAngle - self.ballAngle      
    end
  end
return Ball