WINDOW_WIDTH = 1080
WINDOW_HEIGHT = 608

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

VELOCIDADE = 200

push = require 'push'

function love.load()

    jogador1Y = 10
    jogador2Y = VIRTUAL_HEIGHT - 30
    bolaX = VIRTUAL_WIDTH / 2 -2
    bolaY = VIRTUAL_HEIGHT / 2 - 2

    bolaDX = math.random(2) == 1 and 100 or -100
    bolaDY = math.random(-50, 50)

    estadodoJogo = 'Start'

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    largeFont = love.graphics.newFont('Montserrat-Regular.ttf', 32)
    smallFont = love.graphics.newFont('Montserrat-Regular.ttf', 14)


    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = false,
        vsync = true,
        fullscreen = false
    })
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH,WINDOW_HEIGHT, {upscale = 'normal'})
end

function love.update(dt)
    -- Jogador 1 Movimentação
    if love.keyboard.isDown('w') then
        jogador1Y = math.max(0, jogador1Y + (- VELOCIDADE * dt))
    elseif love.keyboard.isDown('s') then
        jogador1Y = math.min(VIRTUAL_HEIGHT - 20, jogador1Y + VELOCIDADE * dt)
    end

    -- Jogador 2 Movimentação
    if love.keyboard.isDown('up') then
        jogador2Y = math.max(0, jogador2Y + (- VELOCIDADE * dt))
    elseif love.keyboard.isDown('down') then
        jogador2Y = math.min(VIRTUAL_HEIGHT - 20, jogador2Y + VELOCIDADE * dt)
    end

    -- Movimentação da Bola
    if estadodoJogo == 'Play' then
        bolaX = bolaX + bolaDX * dt
        bolaY = bolaY + bolaDY * dt
    end
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

            -- Posição Inicial da Bola
            bolaX = VIRTUAL_WIDTH / 2 - 2
            bolaY = VIRTUAL_HEIGHT / 2 - 2

            -- Velocidade da Bola
            bolaDX = math.random(2) == 1 and 100 or -100
            bolaDY = math.random(-50, 50) * 1.5
        end
    end
end



function love.draw()
    push:start()

    -- Fonte e Background
    love.graphics.clear(52/255, 21/255, 57/255, 1)
    love.graphics.setFont(smallFont)


    -- Jogadores
    jogador1Placar = 0
    jogador2Placar = 0

    -- Primeiro Retângulo
    love.graphics.rectangle('fill', 10, jogador1Y, 5, 20)

    -- Segundo Retângulo
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, jogador2Y, 5, 20)

    -- Bola
    love.graphics.rectangle('fill', bolaX, bolaY, 4, 4)

    -- Placar
    love.graphics.print(tostring(jogador1Placar), VIRTUAL_WIDTH / 2 - 45, 0)
    --love.graphics.print('x', VIRTUAL_WIDTH / 2 - 10, 0)
    love.graphics.print(tostring(jogador2Placar), VIRTUAL_WIDTH / 2 + 25, 0)

    push:finish()
end