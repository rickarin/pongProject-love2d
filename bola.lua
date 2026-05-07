Bola = class {}

function Bola:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Bola:colisao(personagem)
    if self.x >= personagem.x + personagem.width or personagem.x >= self.x + self.width then
        return false
    elseif self.y >= personagem.y + personagem.height or personagem.y >= self.y + self.height then
        return false
    else
        return true
    end
end

function Bola:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = math.random(2) == 1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Bola:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Bola:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
