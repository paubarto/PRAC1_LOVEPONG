local Object = Object or require "object"
local Menu = Object:extend()

function Menu:new()
  self.buttons = {}
  self.font = data.menuTextFont
  self.buttonHeight = data.buttonHeight
  self.buttonWidth = data.buttonWidth
  self.margeY = data.margeY
  self.totalButtonHeight = (self.buttonHeight + self.margeY) * #self.buttons
  self.mouseX, self.mouseY = love.mouse.getPosition()
  self.logo = data.logo
  self.logoX = data.logoX
  self.logoY = data.logoY
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
  
end
function Menu:update(dt)
end
function Menu:draw(w,h)
   self.buttonHeight = data.buttonHeight
   self.buttonWidth = data.buttonWidth
   self.margeY = data.margeY
   self.totalButtonHeight = (self.buttonHeight + self.margeY) * #(self.buttons)
   love.graphics.setFont(self.font)
   self:drawLogo()
     
   for i, button in ipairs(self.buttons) do
     button.last = button.now
     self.xbutton = w/2 - self.buttonWidth / 2
     self.ybutton = h/2 - self.buttonHeight / 2 + self.margeY
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
  return Menu