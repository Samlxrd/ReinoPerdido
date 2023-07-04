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
    require "classes/light"
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
            print(mouse)
        end

        if gameMap == Map[7] then
            if light == nil then
                light = Light()
            end
            light:update(dt)
        end

        world:update(dt)
        level:update(dt)
        player:update(dt)
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

        if light ~= nil then
            light:draw()
        end
    end

    -- Texto de créditos do fim de jogo
    if menu.ingame == 5 then
        local text = 'Parabéns, você conseguiu sobreviver aos desafios,'
        local x = love.graphics.getWidth()
        font = love.graphics.newFont("fonts/PeaberryBase.ttf", 24)
        local fx = font.getWidth(font, text)
        love.graphics.print(text, x/2 - fx/2, 100)
        text = 'agora você está livre e herdou'
        fx = font.getWidth(font, text)
        love.graphics.print(text, x/2 - fx/2, 130)
        
        text = 'todo o território do Reino Perdido!'
        fx = font.getWidth(font, text)
        love.graphics.print(text, x/2 - fx/2, 160)
    end
end

function love.keypressed( key )
    -- Handle para a fase de digitação de sequências
    if gameMap ~= nil and gameMap == Map[5] then
        if typing.sequenceBoss[typing.current] == key then
            typing.current = typing.current + 1

            -- Som de acerto da tecla
            if typing.current ~= #typing.sequenceBoss + 1 then
                sound.sounds.type:stop()
                sound.sounds.type:play()
            end

            -- Som de conclusão de uma sequência
            if typing.current == #typing.sequenceBoss + 1 then
                sound.sounds.pass:stop()
                sound.sounds.pass:play()
                typing:deleteSequence(typing.sequenceBoss)
                typing.current = 1
                typing.wave = typing.wave + 1
                typing.currentTime = 0
            end

        -- Som ao errar
        else
            typing:deleteSequence(typing.sequenceBoss)
            typing.hits = typing.hits + 1
            sound.sounds.hurt:play()
            typing.current = 1
        end

    end

    -- Handle para a fase de GO / STOP
    if gameMap ~= nil and gameMap == Map[7] then
        if light.canWalk == false and (key == 'w' or key == 'a' or key == 's' or key == 'd') then
            sound.sounds.hurt:play()
            light.hit = light.hit + 1
        end
    end
 end