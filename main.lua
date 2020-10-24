local Paddle = Paddle or require "paddle"
local Ball = Ball or require "ball"
local GameScore = GameScore or require "gamescore"
local Menu = Menu or require "menu"
local GameStateController = GameStateController or require "gamestatecontroller"
local Data = Data or require "data"

local w, h -- Variables to store the screen width and height

local DeltaX,DeltaY --Variables to calculate some distances (between paddles and ball, ball and goal offset...)

local standByCounter


function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
  
  w, h = love.graphics.getDimensions() -- Get the screen width and height

  data = Data()
  pPaddle = Paddle(data.playerPaddleX,data.playerPaddleY, data.paddleSpeed, "Player",data.paddleWidth, data.paddleHeight,data.paddleTexture)
  cpuPaddle = Paddle(data.cpuPaddleX,data.cpuPaddleY, data.paddleSpeed, "CPU", data.paddleWidth, data.paddleHeight,data.paddleTexture)
  ball = Ball(data.ballX,data.ballY,data.ballRadius,data.ballAngle,data.initialBallSpeed, data.ballTexture)
  playerScore = GameScore(data.initialScore, data.playerScoreX, data.scoreY)
  cpuScore = GameScore(data.initialScore,data.cpuScoreX, data.scoreY)
  menu = Menu()
  currentGameState = GameStateController()
  
  standByCounter = data.standByCounter
  font = data.font
  bounceSFX = data.bounceSFX
  goalSFX = data.goalSFX
  wallSFX = data.wallSFX
  winningSFX = data.winningSFX
  losingSFX = data.losingSFX
  confirmationSFX = data.confirmationSFX
end

function love.update(dt)
  currentGameState:update(dt)
  if(currentGameState.isPlaying == true and currentGameState.isStandBy == false and currentGameState.isGameOver == false) then 
     pPaddle:update(dt)
     cpuPaddle:update(dt)
     ball:update(dt)
     playerScore:update(dt)
     cpuScore:update(dt)
     pPaddle:checkPlayerCollision(h)
     cpuPaddle:checkCpuCollision()
     ball:checkTopBottomCollision(h)
     checkGoal()
end
if(currentGameState.isStandBy == true and currentGameState.isGameOver == false)then
  standByCounter = standByCounter - dt
  if(standByCounter <= 0) then
        currentGameState.isStandBy = false
        standByCounter = data.standByCounter
        end
  end
  menu:update(dt)
end

function love.draw()
  currentGameState:draw()
  if(currentGameState.isPlaying == true and currentGameState.isGameOver == false) then
   love.graphics.setColor(unpack(data.whiteColor))
   font = data.font  
   pPaddle:draw()
   cpuPaddle:draw()
   ball:draw()
   love.graphics.line(data.lineX1,data.lineY1,data.lineX2,data.lineY2)
   love.graphics.setFont(font)
   playerScore:draw()
   cpuScore:draw()
 end
   --EXTRA (afegir Menú abans de començar partida)
   if(currentGameState.isPlaying == false and currentGameState.isStandBy == false and currentGameState.isGameOver == false) then
     menu:draw(w,h)
  end
  if(currentGameState.isStandBy == true and currentGameState.isGameOver == false) then
    font = data.font
    love.graphics.setFont(font)
    love.graphics.setColor(unpack(data.yellowColor))
    love.graphics.print(math.ceil(standByCounter),data.standByCounterX,data.standByCounterY)
   end
   if(currentGameState.isGameOver == true) then
     font = data.gameOverTextFont
     love.graphics.setFont(font)
     love.graphics.setColor(unpack(data.redColor))
     love.graphics.print(data.gameOverText,data.gameOverTextX,data.gameOverTextY)
     font = data.winnerFont
     if(playerScore.score > cpuScore.score) then
       if(data.hasGameOverAudioPlayed == false) then
       love.audio.stop(goalSFX)
       love.audio.play(winningSFX)
       love.audio.setVolume(data.wSFXVoulme)
       data.hasGameOverAudioPlayed = true
       end
       love.graphics.setFont(font)
       love.graphics.setColor(unpack(data.greenColor))
       love.graphics.print(data.winner1Text, data.winner1TextX, data.winner1TextY)
     end
     if(playerScore.score < cpuScore.score) then
       if(data.hasGameOverAudioPlayed == false) then    
       love.audio.stop(goalSFX)
       love.audio.play(losingSFX)
       data.hasGameOverAudioPlayed = true
       end
       love.graphics.setFont(font)
       love.graphics.print(data.winner2Text,data.winner2TextX , data.winner2TextY)
     end
     end
end
function love.keypressed(key)
    pPaddle:keyPressed(key)
  end
  function love.keyreleased(key)
    pPaddle:keyReleased(key)
    end
  function checkGoal()
    --La porteria del jugador està situat a Posició playerx - 50 i la de la cpu a cpux + 50
    DeltaX = ball.x - (pPaddle.x - data.goalOffset)
    if(DeltaX * DeltaX) < (ball.ballRadius * ball.ballRadius) then
      love.audio.play(goalSFX)
      cpuScore:increaseScore()
      resetBall(false)
    end
    DeltaX = ball.x - (cpuPaddle.x + data.goalOffset)
    if(DeltaX * DeltaX) < (ball.ballRadius * ball.ballRadius) then
      love.audio.play(goalSFX)
      playerScore:increaseScore()
      resetBall(true)
      end
  end
  function resetBall(value)
    pPaddle.canPlayerHit = true
    cpuPaddle.canCpuHit = true   
    pPaddle:resetPosition(data.playerPaddleX, data.playerPaddleY)
    cpuPaddle:resetPosition(data.cpuPaddleX,data.cpuPaddleY)
    currentGameState.isStandBy = true
        --Saca el player, angle que vagi al player
    if value == true then
     ball = Ball(data.ballX,data.ballY,data.ballRadius,data.ballAngle,data.initialBallSpeed, data.ballTexture)
    end
  --Saca cpu, angle que vagi a la cpu (cap adalt 270-360 o abaix 0 - 90)
  if value == false then
    number = math.random(1,2)
    if number == 1 then
    ball =  Ball(data.ballX,data.ballY,data.ballRadius,data.ballAngleForCpu1,data.initialBallSpeed,data.ballTexture)
  end
    if number == 2 then
    ball = Ball(data.ballX,data.ballY,data.ballRadius,data.ballAngleForCpu2,data.initialBallSpeed,data.ballTexture)
    end
    end
    end

