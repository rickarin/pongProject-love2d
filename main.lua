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

    jogador1Placar = 0
    jogador2Placar = 0

    estadodoJogo = 'Start'

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    largeFont = love.graphics.newFont('Montserrat-Regular.ttf', 28)
    smallFont = love.graphics.newFont('Montserrat-Regular.ttf', 14)
    fpsFont = love.graphics.newFont('Montserrat-Regular.ttf', 6)

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
    if estadodoJogo == 'Play' then
        -- Colisão da Bola com Jogador 1
        if bola:colisao(jogador1) then
            bola.dx = -bola.dx * 1.03
            bola.x = jogador1.x + 5

            if bola.dy < 0 then
                bola.dy = -math.random(10, 150)
            else
                bola.dy = math.random(10, 150)
            end
        end

        -- Colisão da Bola com Jogador 2
        if bola:colisao(jogador2) then
            bola.dx = -bola.dx * 1.03
            bola.x = jogador2.x - 4

            if bola.dy < 0 then
                bola.dy = -math.random(10, 150)
            else
                bola.dy = math.random(10, 150)
            end
        end

        -- Colisão da Bola com as partes de cima e de baixo da Janela
        if bola.y <= 0 then
            bola.y = 0
            bola.dy = -bola.dy
        end

        if bola.y >= VIRTUAL_HEIGHT - 4 then
            bola.y = VIRTUAL_HEIGHT - 4
            bola.dy = -bola.dy
        end
    end

    -- Pontuação do Jogo
    if bola.x < 0 then
        jogador2Placar = jogador2Placar + 1
        if jogador2Placar == 3 then
            jogadorVencedor = 2
            estadodoJogo = 'Victory'
        else
            bola:reset()
            estadodoJogo = 'Start'
        end
    end

    if bola.x > VIRTUAL_WIDTH then
        jogador1Placar = jogador1Placar + 1
        if jogador1Placar == 3 then
            jogadorVencedor = 1
            estadodoJogo = 'Victory'
        else
            bola:reset()
            estadodoJogo = 'Start'
        end
    end

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

    -- Resultado da Partida do jogador vencedor
    if estadodoJogo == 'Victory' then
        bola:reset()
        jogador1Placar = 0
        jogador2Placar = 0
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

    if estadodoJogo == 'Victory' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(jogadorVencedor) .. ' venceu', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Aperte enter para recomeçar', 0, 50, VIRTUAL_WIDTH, 'center')
    end

    push:finish()
end

-- Utilidades
function displayFPS()
    love.graphics.setFont(fpsFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1, 1, 1, 1)
end

