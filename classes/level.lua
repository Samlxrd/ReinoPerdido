Level = Classe:extend()

function Level:new()
    Map = {}
    Map[1] = sti('img/map/Map1.lua')
    Map[2] = sti('img/map/Map2.lua')
    Map[3] = sti('img/map/Map3.lua')
    Map[4] = sti('img/map/Map4.lua')
    Map[5] = sti('img/map/Map5.lua')
    Map[6] = sti('img/map/Map6.lua')
    Map[7] = sti('img/map/Map7.lua')
    gameMap = Map[1]
    walls = {}
    self.loadWalls(self)
    end

function Level:update(dt)
    -- Controle de entrada dos mapas (hitbox para passar de mapa)
    -- Instância da próxima fase / reposicionamento do player na fase

    if player.pos.x > 768 and gameMap == Map[1] then
        gameMap = Map[2]
        self.loadWalls(self)
        player.collider:setX(32)
    end

    if player.pos.x < -48*0.8 and gameMap == Map[2] then
        gameMap = Map[1]
        self.loadWalls(self)
        player.collider:setX(736)
    end

    if player.pos.x > 704 and player.pos.x < 736 and player.pos.y > 390 and player.pos.y < 400 and gameMap == Map[2] then
        gameMap = Map[3]
        self.loadWalls(self)
        player.collider:setX(32)
        player.collider:setY(32)
    end

    if player.pos.x > 500 and player.pos.x < 524 and player.pos.y > 115 and player.pos.y < 130 and gameMap == Map[4] then
        gameMap = Map[5]
        self.loadWalls(self)
        player.collider:setX(96)
        player.collider:setY(224)
    end

    if player.pos.x > 80 and player.pos.x < 110 and player.pos.y > 140 and player.pos.y < 160 and gameMap == Map[6] then
        gameMap = Map[7]
        self.loadWalls(self)
        player.collider:setX(24)
        player.collider:setY(24)
    end

    if player.pos.x > 702 and player.pos.x < 736 and player.pos.y > 70 and player.pos.y < 90 and gameMap == Map[7] then
        sound.sounds.pass:play()
        menu.ingame = 5
    end
end

function Level:draw()
    -- Controle das camadas a serem desenhadas de cada fase
    if gameMap == Map[1] then
        gameMap:drawLayer(gameMap.layers["Floor"])
        gameMap:drawLayer(gameMap.layers["Spawn"])
        gameMap:drawLayer(gameMap.layers["TreesDown"])
        gameMap:drawLayer(gameMap.layers["Walls"])
        gameMap:drawLayer(gameMap.layers["Lights"])
        gameMap:drawLayer(gameMap.layers["Trees"])
        gameMap:drawLayer(gameMap.layers["Objects"])
        --world:draw()
        player:draw()
    end

    if gameMap == Map[2] then
        gameMap:drawLayer(gameMap.layers["Floor"])
        gameMap:drawLayer(gameMap.layers["Spawn"])
        gameMap:drawLayer(gameMap.layers["Roof"])
        gameMap:drawLayer(gameMap.layers["Walls"])
        gameMap:drawLayer(gameMap.layers["Objects"])
        gameMap:drawLayer(gameMap.layers["Trees"])
        --world:draw()
        player:draw()
    end

    if gameMap == Map[3] then
        gameMap:drawLayer(gameMap.layers["Floor"])
        gameMap:drawLayer(gameMap.layers["Walls"])
        --world:draw()
        player:draw()
    end

    if gameMap == Map[4] then
        gameMap:drawLayer(gameMap.layers["Floor"])
        gameMap:drawLayer(gameMap.layers["Trees"])
        gameMap:drawLayer(gameMap.layers["Spawn"])
        gameMap:drawLayer(gameMap.layers["Lights"])
        gameMap:drawLayer(gameMap.layers["Stairs"])
        gameMap:drawLayer(gameMap.layers["Roof"])
        gameMap:drawLayer(gameMap.layers["Walls"])
        --world:draw()
        player:draw()
    end

    if gameMap == Map[5] then
        gameMap:drawLayer(gameMap.layers["Floor"])
        gameMap:drawLayer(gameMap.layers["Walls"])
        player:draw()
    end

    if gameMap == Map[6] then
        gameMap:drawLayer(gameMap.layers["Floor"])
        gameMap:drawLayer(gameMap.layers["Spawn"])
        gameMap:drawLayer(gameMap.layers["Lights"])
        gameMap:drawLayer(gameMap.layers["Roof"])
        gameMap:drawLayer(gameMap.layers["Walls"])
        gameMap:drawLayer(gameMap.layers["Roof2"])
        gameMap:drawLayer(gameMap.layers["Stairs"])
        gameMap:drawLayer(gameMap.layers["Trees"])
        gameMap:drawLayer(gameMap.layers["Trees2"])
        player:draw()
    end

    if gameMap == Map[7] then
        gameMap:drawLayer(gameMap.layers["Floor"])
        gameMap:drawLayer(gameMap.layers["Wall"])
        gameMap:drawLayer(gameMap.layers["Roof"])
        gameMap:drawLayer(gameMap.layers["Walls"])
        gameMap:drawLayer(gameMap.layers["Door"])
        player:draw()
    end
end

-- Destroi os colliders anteriores e adicionar os novos da fase
function Level:loadWalls()
    for i, wall in pairs(walls) do
        wall:destroy()
    end

    walls = {}

    if gameMap.layers["WallLayer"] then
        for i, obj in pairs(gameMap.layers["WallLayer"].objects) do
            local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            wall:setType('static')
            wall:setCollisionClass('Solid')
            table.insert(walls, wall)
        end
    end
end