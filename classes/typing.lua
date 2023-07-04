Typing = Classe:extend()

function Typing:new()
    self.keys = {'w', 'a', 's', 'd'}
    self.current = 1
    self.sequenceBoss = {}
    self.sequencePlayer = {}
    self.hits = 0
    self.TimeLimit = 5
    self.currentTime = 0
    self.diff = 4
    self.text = ''
    self.wave = 0
end

function Typing:update(dt)

    -- Se terminou a sequência, gera uma nova
    if #self.sequenceBoss == 0 then
        self.sequenceBoss = self.createSequence(self, self.diff)
    end

    self.currentTime = self.currentTime + dt

    -- Tempo limite para digitar a sequência
    if self.currentTime >= self.TimeLimit then
        self.hits = self.hits + 1
        sound.sounds.hurt:play()
        self.current = 1
        self.currentTime = 0
    end

    -- Se errar ou passar do tempo 3 vezes, perde a fase
    if self.hits >= 3 then
        typing = nil
        gameMap = Map[4]
        level.loadWalls(level)
        player.collider:setX(452)
        player.collider:setY(522)
    end

    -- Increase diff
    if self.wave == 10 then
        self.diff = 5
    end

    -- Increase diff
    if self.wave == 20 then
        self.diff = 6
    end

    -- Passa de fase
    if self.wave == 26 then
        sound.sounds.pass:play()
        gameMap = Map[6]
        level.loadWalls(level)
        player.collider:setX(608)
        player.collider:setY(448)
    end
end

function Typing:draw()

    -- Temporizador
    local timer = string.format("%.0f", self.TimeLimit-self.currentTime)
    local x = love.graphics.getWidth()
    font = love.graphics.newFont("fonts/PeaberryBase.ttf", 24)
    local fx = font.getWidth(font, timer)
    love.graphics.print(timer, x/2 - fx/2, 20)

    -- Sequência
    love.graphics.setFont(font)
    fx = font.getWidth(font, self.text)
    love.graphics.print(self.text, x/2 - fx/2, 40)
end

function Typing:createSequence(n)
    local x = 0
    local sequence = {}
    for i = 1, n do
        x = love.math.random(1,4)
        table.insert(sequence, self.keys[x])
    end

    self.text = ''
    for i, s in ipairs(sequence) do
        self.text = self.text .. ' '.. s .. ''
    end

    return sequence
end

function Typing:deleteSequence(sequence)
    for i, key in ipairs(sequence) do
        table.remove(sequence, i)
    end
    self.sequenceBoss = {}
end