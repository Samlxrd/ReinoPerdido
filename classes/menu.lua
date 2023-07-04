Menu = Classe:extend()

function Menu:new()
    self.ingame = 0
    self.bg = love.graphics.newImage("img/menu/background.png")
    self.btNG = { love.graphics.newImage("img/menu/Button_NewGame.png"), love.graphics.newImage("img/menu/Button_NewGameHover.png")}
    self.btNGS = self.btNG[1]
    self.btAB = { love.graphics.newImage("img/menu/Button_About.png"), love.graphics.newImage("img/menu/Button_AboutHover.png")}
    self.btABS = self.btAB[1]

    wd, he = love.graphics.getDimensions()
    offset, gap = 200, 50
    sound.sounds.bgm:play()
end

function Menu:update(dt)
    local b1 = Vetor(self.btNGS:getWidth(), self.btNGS:getHeight())
    --local b2 = Vetor(self.btABS:getWidth(), self.btABS:getHeight())
    mouse = Vetor(love.mouse.getX(), love.mouse.getY())

    if menu.ingame == 0 then

        if mouse.x > (wd/2 - b1.x/2) and mouse.x < (wd/2 - b1.x/2) + b1.x and mouse.y > offset and mouse.y < offset + b1.y then
            self.btNGS = self.btNG[2]
            if love.mouse.isDown(1) then
                menu.ingame = 1
            end
        else
            self.btNGS = self.btNG[1]
        end

        --[[ --      ABOUT BUTTON
        if mouse.x > (wd/2 - b2.x/2) and mouse.x < (wd/2 - b2.x/2) + b2.x and mouse.y > offset + b1.y + gap and mouse.y < offset + b2.y*2 + gap then
            self.btABS = self.btAB[2]
            if love.mouse.isDown(1) then
                menu.ingame = 4
            end
        else
            self.btABS = self.btAB[1]
        end ]]
    end
end

function Menu:draw()
    love.graphics.draw(self.bg, 0, 0)
    love.graphics.draw(self.btNGS, wd/2 - self.btNGS:getWidth()/2, offset)
    --[[ love.graphics.draw(self.btABS, wd/2 - self.btABS:getWidth()/2, offset + (self.btABS:getHeight() + gap)) ]]
end