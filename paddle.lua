local Object = Object or require "object"
local Paddle = Object:extend()

function Paddle:new(x,y,s,value,paddleWidth,paddleHeight,texture)
   self.x = x
   self.y = y
   self.paddleSpeed = s
   self.initialSpeed = s
   self.paddleHeight = paddleHeight
   self.paddleWidth = paddleWidth
   self.texture = texture
   
   self.canPlayerMoveUpwards = true
   self.canPlayerMoveDownwards = true
   self.canCpuMoveUpwards = true
   self.canCpuMoveDownwards = true
   self.movingUp = false
   self.movingDown = false
   
   self.canPlayerHit = true
   self.canCpuHit = true
   self.value = value
   self.DeltaX = 0
   self.DeltaY = 0
  end
  function Paddle:update(dt)
    if self.canPlayerMoveUpwards == true then
    if self.movingUp == true then
       self.y = self.y - self.paddleSpeed * dt
    end
  end
    if self.canPlayerMoveDownwards == true then
    if self.movingDown == true then
       self.y = self.y + self.paddleSpeed * dt
      end
    end
    if self.value == "CPU" then
      self:cpuAI(dt,love.graphics.getHeight())
      end
  end
  
  function Paddle:draw()
    --love.graphics.rectangle("fill", self.x, self.y, self.paddleWidth, self.paddleHeight)
    love.graphics.draw(self.texture,self.x,self.y,data.pTextureRotation,data.pTextureScale,data.pTextureScale)
  end
  function Paddle:keyPressed(key)
    if key == "up" then
     self.movingUp = true
    end
    if key == "down" then
     self.movingDown = true
    end
  end
  function Paddle:keyReleased(key)
    if key == "up" then
     self.movingUp = false
    end
    if key == "down" then
    self.movingDown = false
    end
  end
  function Paddle:checkPlayerCollision(h)
    --Ball with player paddle collision:
     self.DeltaX = ball.x - math.max(self.x, math.min(ball.x, self.x + self.paddleWidth));
     self.DeltaY = ball.y - math.max(self.y, math.min(ball.y, self.y + self.paddleHeight)); 
     if(self.canPlayerHit == true) then
     if (self.DeltaX * self.DeltaX + self.DeltaY * self.DeltaY) < (ball.ballRadius * ball.ballRadius) then
      --ballSpeed = -(ballSpeed)  TODO 14 comentado
      love.audio.play(bounceSFX)
      ball.ballAngle = data.paddleBounceAngle - ball.ballAngle
      ball.ballSpeed = ball.ballSpeed + data.ballSpeedIncrease
      self.canPlayerHit = false
      cpuPaddle.canCpuHit = true
    end
    end
    --EXTRA per fer que el paddle no surti de la pantalla (player paddle with walls collision)
    if(self.y > data.screenTopPaddleLimit and self.y < data.screenBottomPaddleLimit) then
      self.canPlayerMoveDownwards = true
      self.canPlayerMoveUpwards = true
      end
    if (self.y >= data.screenBottomPaddleLimit) then
      self.y = data.screenBottomPaddleLimit
      self.canPlayerMoveDownwards = false
      self.canPlayerMoveUpwards = true
    end
    if(self.y <= data.screenTopPaddleLimit)  then
      self.y = data.screenTopPaddleLimit
      self.canPlayerMoveUpwards = false
      self.canPlayerMoveDownwards = true
    end
  end
  function Paddle:checkCpuCollision()
     self.DeltaX = ball.x - math.max(self.x, math.min(ball.x, self.x + self.paddleWidth));
     self.DeltaY = ball.y - math.max(self.y, math.min(ball.y, self.y + self.paddleHeight)); 
     if(self.canCpuHit == true) then
     if (self.DeltaX * self.DeltaX + self.DeltaY * self.DeltaY) < (ball.ballRadius * ball.ballRadius) then
      --ballSpeed = -(ballSpeed)  TODO 15 comentado
      love.audio.play(bounceSFX)
      ball.ballAngle = data.paddleBounceAngle - ball.ballAngle
      ball.ballSpeed = ball.ballSpeed + data.ballSpeedIncrease
      self.canCpuHit = false
      pPaddle.canPlayerHit = true
    end
  end
end
  
  function Paddle:resetPosition(x, y)
    self.x = x
    self.y = y
  end
  function Paddle:cpuAI(dt,h)
    if(self.y > data.screenTopPaddleLimit and self.y < data.screenBottomPaddleLimit) then
      self.canCpuMoveDownwards = true
      self.canCpuMoveUpwards = true
      end
    if (self.y >= data.screenBottomPaddleLimit) then
      self.y = data.screenBottomPaddleLimit
      self.canCpuMoveDownwards = false
      self.canCpuMoveUpwards = true
    end
    if(self.y <= data.screenTopPaddleLimit)  then
      self.y = data.screenTopPaddleLimit
      self.canCpuMoveUpwards = false
      self.canCpuMoveDownwards = true
    end
  --Càlcul moviment pala cpu
  self.DeltaY = (ball.y - self.y)
  -- Si la resta és negativa vol dir que la pilota està per damunt, cal anar cap a dalt
  if self.canCpuMoveUpwards == true then
  if (self.DeltaY < 0) then
    self.y = self.y - self.paddleSpeed * dt
  end
end
  if self.canCpuMoveDownwards == true then
  if(self.DeltaY > 0) then
    self.y = self.y + self.paddleSpeed * dt
  end
  end
end
  return Paddle