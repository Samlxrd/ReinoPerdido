Light = Classe:extend()

function Light:new()
    self.hit = 0
    self.canWalk = true
    self.text = ''
    self.go = 0
    self.interval = -1
    self.s = 0
end

function Light:update(dt)
    -- Se acabou o tempo de andar
    if self.go <= 0 then
        -- Tempo de pausa começa a correr
        self.interval = self.interval - dt

        -- Acabou intervalo
        if self.interval <= 0 then
            self.interval = love.math.random (2,4)
            self.go = love.math.random(1,3)
            self.canWalk = true
            sound.sounds.walk:stop()
            sound.sounds.walk:play()
            self.s = 0

        -- Durante intervalo
        else
            self.canWalk = false
            if self.s == 0 then
                sound.sounds.stop:stop()
                sound.sounds.stop:play()
                self.s = 1
            end
        end
    end

    self.go = self.go - dt

    if self.canWalk == true then
        self.text = 'GO!'
    else
        self.text = 'STOP!'
    end

    -- Se andar mais de uma vez no momento de STOP, perde a fase
    if self.hit > 1 then
        light = nil
        gameMap = Map[6]
        level.loadWalls(level)
        player.collider:setX(645)
        player.collider:setY(490)
    end
end

function Light:draw()
    -- Display do GO / STOP
    local x = love.graphics.getWidth()
    font = love.graphics.newFont("fonts/PeaberryBase.ttf", 24)
    love.graphics.setFont(font)
    local fx = font.getWidth(font, self.text)
    love.graphics.print(self.text, x/2 - fx/2, 20)
end