Sound = Classe:extend()

function Sound:new()
    self.sounds = {}
    self.sounds.pass = love.audio.newSource('sounds/pass.mp3', 'static')
    self.sounds.hurt = love.audio.newSource('sounds/hurt.wav', 'static')
    self.sounds.type = love.audio.newSource('sounds/typehit.mp3', 'static')
    self.sounds.fight1 = love.audio.newSource('sounds/fight1.mp3', 'stream')
    self.sounds.bgm = love.audio.newSource('sounds/bgm.mp3', 'stream')
    self.sounds.stop = love.audio.newSource('sounds/stop.wav', 'static')
    self.sounds.walk = love.audio.newSource('sounds/walk.wav', 'static')
    self.sounds.bgm:setLooping(true)

    self.sounds.pass:setVolume(0.05)
    self.sounds.hurt:setVolume(0.1)
    self.sounds.type:setVolume(0.05)
    self.sounds.stop:setVolume(0.05)
    self.sounds.walk:setVolume(0.05)
    self.sounds.fight1:setVolume(0.05)
    self.sounds.bgm:setVolume(0.05)
end

function Sound:update(dt)

end

function Sound:draw()

end