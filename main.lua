WINDOW_WIDTH = 1080
WINDOW_HEIGHT = 608

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    largeFont = love.graphics.newFont('Montserrat-Regular.ttf', 32)
    smallFont = love.graphics.newFont('Montserrat-Regular.ttf', 8)
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        fullscreen = false
    })
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH,WINDOW_HEIGHT, {upscale = 'normal'})
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:start()

    -- Fonte
    love.graphics.clear(52/255, 21/255, 57/255, 1)
    love.graphics.setFont(largeFont)

    -- Jogadores
    jogador1Placar = 0
    jogador2Placar = 0

    -- Primeiro Retângulo
    love.graphics.rectangle('fill', 10, 10, 5, 20)

    -- Segundo Retângulo
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 5, 20)

    -- Bola
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 4, VIRTUAL_HEIGHT / 2 - 4, 4, 4)

    -- Placar
    love.graphics.print(tostring(jogador1Placar), VIRTUAL_WIDTH / 2 - 45, 0)
    --love.graphics.print('x', VIRTUAL_WIDTH / 2 - 10, 0)
    love.graphics.print(tostring(jogador2Placar), VIRTUAL_WIDTH / 2 + 25, 0)

    push:finish()
end