function love.conf(t)
    t.console = true
    t.window.title = "Game Final"
    t.window.icon = nil
    t.window.width = 768
    t.window.height = 576
    t.window.resizable = false
    t.window.vsync = true

    config = {
        keybinds = {
            {
                up = 'w',
                right = 'd',
                left = 'a',
                down = 's'
            },
            {
                up = 'up',
                right = 'right',
                left = 'left',
                down = 'down'
            }
        }
    }
end