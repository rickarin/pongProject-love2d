WINDOW_WIDTH = 1080
WINDOW_HEIGHT = 608

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

VELOCIDADE = 200

push = require 'push'
class = require 'class'
require 'bola'
require 'Personagem'

function love.load()

    jogador1 = Personagem(10, 10, 5, 20)
    jogador2 = Personagem(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 5, 20)
    bola = Bola(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    estadodoJogo = 'Start'

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    largeFont = love.graphics.newFont('Montserrat-Regular.ttf', 32)
    smallFont = love.graphics.newFont('Montserrat-Regular.ttf', 14)
    fpsFont = love.graphics.newFont('Montserrat-Regular.ttf', 8)

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        fullscreen = false
    })
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        upscale = 'normal'
    })
end

function love.update(dt)
    -- Jogador 1 Movimentação
    if love.keyboard.isDown('w') then
        jogador1.dy = -VELOCIDADE
    elseif love.keyboard.isDown('s') then
        jogador1.dy = VELOCIDADE
    else
        jogador1.dy = 0
    end

    -- Jogador 2 Movimentação
    if love.keyboard.isDown('up') then
        jogador2.dy = -VELOCIDADE
    elseif love.keyboard.isDown('down') then
        jogador2.dy = VELOCIDADE
    else
        jogador2.dy = 0
    end

    -- Movimentação da Bola
    if estadodoJogo == 'Play' then
        bola:update(dt)
    end

    jogador1:update(dt)
    jogador2:update(dt)
end

function love.keypressed(key)
    -- Botão para fechar o jogo
    if key == 'escape' then
        love.event.quit()

        -- Mudança de Estado do Jogo
    elseif key == 'enter' or key == 'return' then
        if estadodoJogo == 'Start' then
            estadodoJogo = 'Play'
        else
            estadodoJogo = 'Start'

            bola:reset()
        end
    end
end

function love.draw()
    push:start()

    -- Fonte e Background
    love.graphics.clear(52 / 255, 21 / 255, 57 / 255, 1)
    love.graphics.setFont(smallFont)

    -- Jogadores
    jogador1Placar = 0
    jogador2Placar = 0

    -- Primeiro Retângulo
    jogador1:render()

    -- Segundo Retângulo
    jogador2:render()

    -- Bola
    bola:render()

    -- Placar
    love.graphics.print(tostring(jogador1Placar), VIRTUAL_WIDTH / 2 - 45, 0)
    love.graphics.print(tostring(jogador2Placar), VIRTUAL_WIDTH / 2 + 25, 0)

    displayFPS()

    push:finish()
end

-- Utilidades
function displayFPS()
    love.graphics.setFont(fpsFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1, 1, 1, 1)
end

