Attack = GameObject:extend()

function Attack:new(area, x, y, opts)
    Attack.super.new(self, area, x, y, opts)

    local direction = table.random({-1, 1})
    self.x = gw/2 + direction*(gw/2 + 48)
    self.y = random(16, gh - 16)

    self.w, self.h = 10, 10
    self.collider = self.area.world:newRectangleCollider(self.x, self.y, self.w, self.h)
    self.collider:setObject(self)
    self.collider:setCollisionClass('Collectable')
    self.collider:setFixedRotation(false)
    self.v = -direction*random(20, 40)
    self.collider:setLinearVelocity(self.v, 0)
    self.collider:applyAngularImpulse(random(-24, 24))

    self.font = fonts.m5x7_16
    self.attack = table.random({'Double', 'Triple', 'Rapid', 'Spread', 'Back', 'Side'})
end

function Attack:update(dt)
    Attack.super.update(self, dt)

    self.collider:setLinearVelocity(self.v, 0)
end

function Attack:draw()
    pushRotateScale(self.x, self.y, 0, random(0.95, 1.05), random(0.95, 1.05))
    love.graphics.setColor(attacks[self.attack].color)
    if self.attack == 'Spread' then love.graphics.setColor(table.random(all_colors)) end
    love.graphics.print(attacks[self.attack].abbreviation, self.x, self.y, 0, 1, 1, math.floor(self.font:getWidth(attacks[self.attack].abbreviation)/2), math.floor(self.font:getHeight()/2))
    draft:rhombus(self.x, self.y, 3*self.w, 3*self.w, 'line')
    love.graphics.setColor(default_color)
    draft:rhombus(self.x, self.y, 2.5*self.w, 2.5*self.w, 'line')
    love.graphics.pop()
end

function Attack:destroy()
    Attack.super.destroy(self)
end

function Attack:die()
    self.dead = true
    self.area:addGameObject('AttackEffect', self.x, self.y, {color = default_color, w = 1.1*self.w, h = 1.1*self.h}) 
    if self.attack == 'Spread' then self.area:addGameObject('AttackEffect', self.x, self.y, {color = table.random(all_colors), w = 1.3*self.w, h = 1.3*self.h}) 
    else self.area:addGameObject('AttackEffect', self.x, self.y, {color = attacks[self.attack].color, w = 1.3*self.w, h = 1.3*self.h}) end
    self.area:addGameObject('InfoText', self.x + table.random({-1, 1})*self.w, self.y + table.random({-1, 1})*self.h, {color = default_color, text = self.attack})
end