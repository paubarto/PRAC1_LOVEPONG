local Object = Object or require "object"
local Menu = Object:extend()

function Menu:new()
  self.buttons = {}
  self.gameOverButtons = {}
  self.currentList = {}
  self.font = data.menuTextFont
  self.buttonHeight = data.buttonHeight
  self.buttonWidth = data.buttonWidth
  self.margeY = data.margeY
  self.totalButtonHeight = (self.buttonHeight + self.margeY) * #self.buttons
  self.mouseX, self.mouseY = love.mouse.getPosition()
  self.logo = data.logo
  self.logoX = data.logoX
  self.logoY = data.logoY
  self:makeButtons()
end
function Menu:update(dt)
end
function Menu:draw(w,h)
   self.buttonHeight = data.buttonHeight
   self.buttonWidth = data.buttonWidth
   self.margeY = data.margeY
   if(currentGameState.isPlaying == false and currentGameState.isGameOver == false) then
     self.currentList = self.buttons
     love.graphics.setFont(self.font)
     self.color = data.whiteColor
     love.graphics.setColor(unpack(self.color))
     love.graphics.print(data.menuInfo1,data.menuInfoX,data.menuInfo1Y)
     love.graphics.print(data.menuInfo2,data.menuInfoX,data.menuInfo2Y)
     self:drawLogo()
   end
   if(currentGameState.isGameOver == true) then
     self.currentList = self.gameOverButtons
   end
   if(#(self.currentList) >= 1) then
   self.totalButtonHeight = (self.buttonHeight + self.margeY) * #(self.currentList)
    
   for i, button in ipairs(self.currentList) do
     button.last = button.now
     self.xbutton = w/2 - self.buttonWidth / 2
     if(currentGameState.isGameOver == false) then
     self.ybutton = h/2 - self.buttonHeight / 2 + self.margeY
    end
     if(currentGameState.isGameOver == true) then
     self.ybutton = (h - h/4) - self.buttonHeight / 2 + self.margeY
    end
     self.color =  data.grayColor
    -- local mouseX, mouseY = love.mouse.getPosition()
     self.mouseX, self.mouseY = love.mouse.getPosition()
     self.highlight = self.mouseX > self.xbutton and self.mouseX < self.xbutton + self.buttonWidth and self.mouseY > self.ybutton and self.mouseY <      self.ybutton + self.buttonHeight
     if self.highlight then
       self.color = data.highlightColor
       end
      button.now = love.mouse.isDown(1)
      if button.now and not button.last and self.highlight then
        button.fnction()
        end
     love.graphics.setColor(unpack(self.color))
     love.graphics.rectangle("fill",self.xbutton, self.ybutton, self.buttonWidth,self.buttonHeight)  
     --Menu text print
     self.color = love.graphics.setColor(unpack(data.blackColor))
     self.textWidth = self.font:getWidth(button.text)
     self.textHeight = self.font:getWidth(button.text)
     love.graphics.print(button.text, self.font, w/2 - self.textWidth/2, self.ybutton + self.textHeight/2)
     self.margeY = self.margeY + data.margeYIncrease 
    end
    end
  end
 function Menu:newButton(text, fnction)
 return {
    text = text, fnction = fnction,
    now = false, last = false
    }
  end
  function Menu:drawLogo()
     self.color = data.whiteColor
     love.graphics.setColor(unpack(self.color))
     love.graphics.draw(self.logo, self.logoX, self.logoY,data.logoRotation,data.logoScale,data.logoScale)
    end
    function Menu:makeButtons()
      table.insert(self.buttons, self:newButton(
      "Play",
      function()
        print("Starting game")
        love.audio.play(confirmationSFX)
        love.audio.setVolume(data.confirmationSFXVolume)
        currentGameState.isPlaying = true
        data.gameLimit = 5
        end
      ))
    table.insert(self.buttons, self:newButton(
      "Play",--"Play",
      function()
        print("Starting game")
        love.audio.play(confirmationSFX)
        love.audio.setVolume(data.confirmationSFXVolume)
        currentGameState.isPlaying = true
        data.gameLimit = 10
        end
      ))
     table.insert(self.buttons, self:newButton(
      "Exit",
      function()
        love.event.quit(0)
        end
      ))
      table.insert(self.gameOverButtons, self:newButton(
          "Reset",
          function()
            print("Restarting Game")
            currentGameState.isPlaying = false
            currentGameState.isGameOver = false
            currentGameState.isStandBy = false
            playerScore.score = data.initialScore
            cpuScore.score = data.initialScore  
            data.hasGameOverAudioPlayed = false
          end
        ))
      table.insert(self.gameOverButtons, self:newButton(
          "Exit",
          function()
            love.event.quit(0)
          end
          ))
      end
    function Menu:drawGameOverMenu()
      
      end
  return Menu