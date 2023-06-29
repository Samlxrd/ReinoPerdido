Menu = Classe:extend()

function Menu:new()
    self.ingame = 0
    self.bg = love.graphics.newImage("img/menu/background.png")
    self.btNG = { love.graphics.newImage("img/menu/Button_NewGame.png"), love.graphics.newImage("img/menu/Button_NewGameHover.png")}
    self.btNGS = self.btNG[1]
    self.btLG = { love.graphics.newImage("img/menu/Button_LoadGame.png"), love.graphics.newImage("img/menu/Button_LoadGameHover.png")}
    self.btLGS = self.btLG[1]
    self.btAB = { love.graphics.newImage("img/menu/Button_About.png"), love.graphics.newImage("img/menu/Button_AboutHover.png")}
    self.btABS = self.btAB[1]

    wd, he = love.graphics.getDimensions()
    offset, gap = 200, 20
    sound.sounds.bgm:play()
end

function Menu:update(dt)
    local b1 = Vetor(self.btNGS:getWidth(), self.btNGS:getHeight())
    local b2 = Vetor(self.btLGS:getWidth(), self.btLGS:getHeight())
    local b3 = Vetor(self.btABS:getWidth(), self.btABS:getHeight())
    mouse = Vetor(love.mouse.getX(), love.mouse.getY())

    if menu.ingame == 0 then

        if mouse.x > (wd/2 - b1.x/2) and mouse.x < (wd/2 - b1.x/2) + b1.x and mouse.y > offset and mouse.y < offset + b1.y then
            self.btNGS = self.btNG[2]
            --sound.sounds.pass:play()
            if love.mouse.isDown(1) then
                menu.ingame = 1
            end
        else
            self.btNGS = self.btNG[1]
        end

        --      LOAD GAME BUTTON
        if mouse.x > (wd/2 - b2.x/2) and mouse.x < (wd/2 - b2.x/2) + b2.x and mouse.y > offset + b1.y + gap and mouse.y < offset + b2.y*2 + gap then
            self.btLGS = self.btLG[2]
            if love.mouse.isDown(1) then
                player = Player()
                level = Level()
                gameMap = Map[4]
                level.loadWalls(level)
                player.collider:setX(64)
                player.collider:setY(512)
                menu.ingame = 2
            end
        else
            self.btLGS = self.btLG[1]
        end

        --      ABOUT BUTTON
        if mouse.x > (wd/2 - b3.x/2) and mouse.x < (wd/2 - b3.x/2) + b3.x and mouse.y > offset + (b2.y + gap)*2 and mouse.y < offset + b3.y*3 + gap*2 then
            self.btABS = self.btAB[2]
            if love.mouse.isDown(1) then
                menu.ingame = 5
            end
        else
            self.btABS = self.btAB[1]
        end
    end
end

function Menu:draw()
    love.graphics.draw(self.bg, 0, 0)
    love.graphics.draw(self.btNGS, wd/2 - self.btNGS:getWidth()/2, offset)
    love.graphics.draw(self.btLGS, wd/2 - self.btLGS:getWidth()/2, offset + self.btNGS:getHeight() + gap)
    love.graphics.draw(self.btABS, wd/2 - self.btABS:getWidth()/2, offset + (self.btLGS:getHeight() + gap) * 2)
end