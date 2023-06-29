Fire = Classe:extend()

function Fire:new()
    ProjectileList = {}
    self.TimeLimit = 60
    self.counter = 0
    self.intervalCounter = 0
    self.interval = 3
    self.img = love.graphics.newImage('img/entity/fireball.png')


    -- Animations
    self.spriteSheet = love.graphics.newImage('img/entity/goblin.png')
    self.grid = anim8.newGrid(48, 48, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid('1-1', 2), 0.4)
    self.animations.down = anim8.newAnimation(self.grid('1-4', 1), 0.4)
    self.animations.left = anim8.newAnimation(self.grid('1-4', 2), 0.4)
    self.animations.right = anim8.newAnimation(self.grid('1-4', 3), 0.4)
    self.animations.up = anim8.newAnimation(self.grid('1-4', 4), 0.4)
    self.anim = self.animations.idle

    self.pos = Vetor(width-48, height-48)
    self.speed = 2
    self.hits = 0
    self.dir = 0
end

function Fire:update(dt)
    self.counter = self.counter + dt
    self.intervalCounter = self.intervalCounter + dt

    for i, prj in ipairs(ProjectileList) do
        prj.pos.x = prj:getX()
        prj.pos.y = prj:getY()
    end

    -- Conseguiu sobreviver [ Passou de Fase ]
    if self.counter >= self.TimeLimit then
        for i, prj in pairs(ProjectileList) do
            prj:destroy()
        end
        if sound.sounds.fight1:isPlaying() then
            sound.sounds.fight1:stop()
        end
        gameMap = Map[4]
        level.loadWalls(level)
        player.collider:setX(64)
        player.collider:setY(512)
    end

    -- Spawna projétil [ Ataque do goblin ]
    if self.intervalCounter >= self.interval then
        self.intervalCounter = 0
        if #ProjectileList == 4 then
            ProjectileList[1]:destroy()
            table.remove(ProjectileList, 1)
        end
        self:generateProjectile()
    end

    -- Verifica colisão dos projéteis com o player
    for i, prj in ipairs(ProjectileList) do
        if prj:enter('Player') then
            sound.sounds.hurt:play()
            prj:destroy()
            table.remove(ProjectileList, i)
            self.hits = self.hits + 1
        end
    end

    self.dir = player.pos.y - self.pos.y

    if  self.dir > 0 then
        self.pos.y = self.pos.y + self.speed
    else
        self.pos.y = self.pos.y - self.speed
    end

    if self.hits == 3 then
        for i, prj in pairs(ProjectileList) do
            prj:destroy()
        end
        if sound.sounds.fight1:isPlaying() then
            sound.sounds.fight1:stop()
        end
        fire = nil
        gameMap = Map[1]
        player.collider:destroy()
        player = Player()
        level.loadWalls(level)
    end
end

function Fire:draw()
    if #ProjectileList > 0 then
        for i, prj in ipairs(ProjectileList) do
            love.graphics.draw(self.img, prj.pos.x, prj.pos.y)
        end
    end

    local x = love.graphics.getWidth()
    font = love.graphics.newFont("fonts/PeaberryBase.ttf", 24)
    love.graphics.setFont(font)
    text = "Sobreviva: " .. string.format("%.0f", self.TimeLimit-self.counter)
    local fx = font.getWidth(font, text)
    love.graphics.print(text, x/2 - fx/2, 30)

    self.anim:draw(self.spriteSheet, self.pos.x-48*0.4, self.pos.y-48*0.5, nil, 0.8)
end

function Fire:generateProjectile()
    local r = love.math.random(1,2)
    local pos = Vetor(740, self.pos.y+16)
    local pj = world:newCircleCollider(pos.x, pos.y, 5)

    pj.pos = pos
    pj:setCollisionClass('Projectile')
    pj:setRestitution(1)
    pj:applyLinearImpulse(-120, self.dir/math.abs(self.dir)*love.math.random(1,10))

    table.insert(ProjectileList, pj)
end