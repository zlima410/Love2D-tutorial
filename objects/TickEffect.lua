TickEffect = GameObject:extend()

function TickEffect:new(area, x, y, opts)
    TickEffect.super.new(self, area, x, y, opts)
    self.depth = 75

    self.w, self.h = 48, 4
    self.x_offset = 0
    self.timer:tween(0.13, self, {w = 0, x_offset = 48}, 'in-out-cubic', function() self.dead = true end)
end

function TickEffect:update(dt)
    TickEffect.super.update(self, dt)
    if self.parent then self.x, self.y = gw/2 + 4, gh - 16 end
end

function TickEffect:draw()
    love.graphics.setColor(default_color)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    love.graphics.setColor(1, 1, 1)
end

function TickEffect:destroy()
    TickEffect.super.destroy(self)
end