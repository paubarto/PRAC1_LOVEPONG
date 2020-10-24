local Object = Object or require "object"
local Data = Object:extend()

function Data:new()
  self.w = love.graphics.getWidth()
  self.h = love.graphics.getHeight()
  --Variables per dibuixar la linia del mig del camp
  self.lineX1 = self.w / 2
  self.lineX2 = self.lineX1
  self.lineY1 = self.h
  self.lineY2 = 50 - 50
  --Variables de posicions i dimensions de les pales
  self.paddleHeight = 50
  self.paddleWidth = 10
  self.paddleSpeed = 200
  self.playerPaddleX = 100
  self.playerPaddleY = (self.h/ 2) - (self.paddleHeight / 2)
  self.cpuPaddleX = self.w - 100
  self.cpuPaddleY = self.playerPaddleY
  self.pTextureRotation = 50 - 50
  self.pTextureScale = 1
  self.screenTopPaddleLimit = 50 - 50  --(0), si posava 0 directament donava errors
  self.screenBottomPaddleLimit = self.h - self.paddleHeight  
  self.paddleBounceAngle = 180
  --Variables de posicions,velocitats,angles i radi de la pilota
  self.ballRadius = 10
  self.ballX = (self.w / 2 ) - self.ballRadius
  self.ballY = self.h / 2
  self.initialBallSpeed = 300
  self.ballSpeedIncrease = 25 --cada cop que rebota amb un paddle aumentarà la velocitat en 25
  self.ballAngle = math.random(140,220)
  self.ballAngleForCpu1 = math.random(20, 50)
  self.ballAngleForCpu2 = math.random(310, 340)
  self.bTextureRotation = 50 - 50
  self.bTextureScale = 1
  self.wallBounceAngle = 360
  self.screenTopBallLimit = 10
  self.screenBottomBallLimit = self.h
  --Variable que és la distància entre una pala i on la bola desapareix i es marca gol
  self.goalOffset = 100 - 50
  --Variables relacionades amb les posicions i valors inicials de les puntuacions de player i cpu
  self.initialScore = 50 - 50 --Si posava 0 donava error al passar-ho desde main al crear l'objecte playerscore o cpuscore
  self.playerScoreX = self.w / 3
  self.cpuScoreX = self.w - (self.w / 3 )
  self.scoreY = 25
  --Variables relacionades amb el contador groc que apareix quan el joc està en standBy
  self.standByCounter = 3
  self.standByCounterX = self.w / 2.05
  self.standByCounterY = self.h / 3
  --Variables relacionades amb les mides i offsets dels botons dels menús
  self.buttonWidth = self.w/3
  self.buttonHeight = 64
  self.margeY = 50 - 50
  self.margeYIncrease = 100
  --Variables relacionades amb les posicions i dimensions del logo
  self.logoX = self.w / 3.4
  self.logoY = self.h / 14
  self.logoRotation = 50 - 50
  self.logoScale = 1  
  --Variables que emmagatzemen els valors dels diferents colors utilitzats
  self.whiteColor = {1,1,1,1}
  self.yellowColor = {1,1,0.2,1}
  self.greenColor = {0,1,0,1}
  self.redColor = {1,0,0,1}
  self.blackColor = {0,0,0,1}
  self.grayColor = {0.4,0.4,0.4,1}
  self.highlightColor = {0.8,0.8,0.8,1}
  --Limit del joc, quan algú dels 2 arriba a aquesta puntuació, salta el gameOver
  self.gameLimit = 5
  --Variables relacionades amb el text de Game Over i els de qui guanya
  self.gameOverText = "Game Over!"
  self.gameOverTextX = 240 - 120
  self.gameOverTextY = 300 - 150
  self.winner1Text = "Player wins!"
  self.winner1TextX = 500 - 250
  self.winner1TextY =  500 - 250
  self.winner2Text = "CPU wins"
  self.winner2TextX = 600 - 300
  self.winner2TextY = 500 - 250
  self.hasGameOverAudioPlayed = false
  --Variables que emmagatzemen les diferents fonts, imatges i sons
  self.font = love.graphics.newFont("Resources/pong.ttf", 75)  
  self.menuTextFont = love.graphics.newFont("Resources/pong.ttf", 25)  
  self.gameOverTextFont = love.graphics.newFont("Resources/pong.ttf", 100) 
  self.winnerFont =  love.graphics.newFont("Resources/pong.ttf", 50) 
  self.confirmationSFX = love.audio.newSource("Resources/confirmationSFX.ogg","stream")
  self.confirmationSFXVolume = 0.3
  self.bounceSFX = love.audio.newSource("Resources/pongbouncesfx.ogg", "stream")
  self.goalSFX = love.audio.newSource("Resources/ponggoalsfx.ogg","stream")
  self.wallSFX = love.audio.newSource("Resources/wallbouncesfx.ogg","stream")
  self.losingSFX = love.audio.newSource("Resources/losingSFX.ogg","stream")
  self.winningSFX = love.audio.newSource("Resources/winningSFX.ogg","stream")
  self.wSFXVoulme = 0.5
  self.logo = love.graphics.newImage("Resources/pong.jpg")
  self.ballTexture = love.graphics.newImage("Resources/pongBall.png")
  self.paddleTexture = love.graphics.newImage("Resources/paddle.png")
end
return Data