function love.load()

    -- Libraries
    Classe = require "libraries/classic"
    Vetor = require "libraries/vector"
    anim8 = require "libraries/anim8"
    wf = require "libraries/windfield"
    sti = require "libraries/sti"

    -- Classes
    require "classes/typing"
    require "classes/player"
    require "classes/sound"
    require "classes/level"
    require "classes/menu"
    require "classes/fire"

    love.graphics.setDefaultFilter("nearest", "nearest")

    --  World & collision classes
    world = wf.newWorld(0, 0)
    world:addCollisionClass('Solid')
    world:addCollisionClass('Player')
    world:addCollisionClass('Projectile')

    sound = Sound()
    menu = Menu()
end

function love.update(dt)
    -- Se clicar no botão de jogo, carrega instancia as classes
    if menu.ingame == 1 then
        player = Player()
        level = Level()
        menu.ingame = 2
    end

    -- Lógica de jogo
    if menu.ingame == 2 then
        if sound.sounds.bgm:isPlaying() then
            sound.sounds.bgm:stop()
        end

        if gameMap == Map[3] then
            if fire == nil then
                fire = Fire()
                sound.sounds.fight1:play()
            end
            fire:update(dt)
        end

        if gameMap == Map[4] then
            if fire ~= nil then
                fire = nil
            end
        end

        if gameMap == Map[5] then
            if typing == nil then
                typing = Typing()
            end
            typing:update(dt)
        end

        if gameMap == Map[6] then
            if typing ~= nil then
                typing = nil
            end
        end

    -- Carrega o save do arquivo


        world:update(dt)
        level:update(dt)
        player:update(dt)
    end

    if menu.ingame == 5 then
        
    end

    menu:update(dt)
end

function love.draw()
    if menu.ingame == 0 then
        menu:draw()
    end
    --world:draw()
    if menu.ingame == 2 then
        level:draw()
        if fire ~= nil then
            fire:draw()
        end

        if typing ~= nil then
            typing:draw()
        end
    end
end