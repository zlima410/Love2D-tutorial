Attack = GameObject:extend()

function Attack:new(area, x, y, opts)
    Attack.super.new(self, area, x, y, opts)

    local direction = table.random({-1, 1})
    self.x = gw/2 + direction*(gw/2 + 48)
    self.y = random(48, gh - 48)
    self.font = fonts.m5x7_16

    self.attack_name = table.randomKey(attacks, 'Neutral')
    self.attack = attacks[self.attack_name]

    self.w, self.h = 18, 18
    self.collider = self.area.world:newRectangleCollider(self.x, self.y, self.w, self.h)
    self.collider:setObject(self)
    self.collider:setCollisionClass('Collectable')
    self.collider:setFixedRotation(false)
    self.v = -direction*random(20, 40)
    self.collider:setLinearVelocity(self.v, 0)
end

function Attack:update(dt)
    Attack.super.update(self, dt)

    self.collider:setLinearVelocity(self.v, 0)
end

function Attack:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(self.attack.color)
    love.graphics.print(self.attack.abbreviation, self.x, self.y, 0, 1, 1, self.font:getWidth(self.attack.abbreviation)/2, self.font:getHeight()/2)
    pushRotate(self.x, self.y, self.collider:getAngle())
    draft:rhombus(self.x, self.y, 2*self.w, 2*self.h, 'line')
    love.graphics.setColor(default_color)
    draft:rhombus(self.x, self.y, 1.5*self.w, 1.5*self.h, 'line')
    love.graphics.pop()
    love.graphics.setColor(default_color)
end

function Attack:destroy()
    Attack.super.destroy(self)
end

function Attack:die()
    self.dead = true
    self.area:addGameObject('AttackEffect', self.x, self.y, {color = self.attack.color, w = self.w, h = self.h})
    self.area:addGameObject('InfoText', self.x + table.random({-1, 1})*self.w, self.y + table.random({-1, 1})*self.h, {color = default_color, text = self.attack_name})
end