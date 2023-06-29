Player = Classe:extend()

function Player:new()
    width, height = love.graphics.getDimensions()
    self.spriteSheet = love.graphics.newImage('img/player/player.png')

    -- Animations
    self.grid = anim8.newGrid(48, 48, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    self.animations = {}
    self.animations.idle = anim8.newAnimation(self.grid('1-1', 1), 0.2)
    self.animations.down = anim8.newAnimation(self.grid('1-4', 1), 0.2)
    self.animations.left = anim8.newAnimation(self.grid('1-4', 2), 0.2)
    self.animations.right = anim8.newAnimation(self.grid('1-4', 3), 0.2)
    self.animations.up = anim8.newAnimation(self.grid('1-4', 4), 0.2)
    self.anim = self.animations.idle

    self.keybinds = config.keybinds[1]
    self.pos = Vetor(32, 96)
    self.speed = 200

    -- Collider
    self.collider = world:newBSGRectangleCollider(self.pos.x, self.pos.y, 48*0.5, 48*0.6, 8)
    self.collider:setFixedRotation(true)
    self.collider:setCollisionClass('Player')
end

function Player:update(dt)
    local vx, vy = 0,0
    if self.keybinds and gameMap ~= Map[5] then
        if love.keyboard.isDown(self.keybinds.up) then
            self.anim = self.animations.up
            vy = self.speed * -1
        --end

    elseif love.keyboard.isDown(self.keybinds.down) then
            self.anim = self.animations.down
            vy = self.speed
        --end

    elseif love.keyboard.isDown(self.keybinds.right) then
            self.anim = self.animations.right
            vx = self.speed

        elseif love.keyboard.isDown(self.keybinds.left) then
            self.anim = self.animations.left
            vx = self.speed * -1

        else
            self.anim = self.animations.idle
        end
    end

    self.collider:setLinearVelocity(vx, vy)
    self.pos.x = self.collider:getX()
    self.pos.y = self.collider:getY()

    self.anim:update(dt)
    --print(self.pos)
end

function Player:draw()
    self.anim:draw(self.spriteSheet, self.pos.x-48*0.4, self.pos.y-48*0.5, nil, 0.8)
end