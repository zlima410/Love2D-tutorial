Stage = Object:extend()

function Stage:new()
    self.area = Area(self)
    self.area:addPhysicsWorld()
    self.area.world:addCollisionClass('Enemy')
    self.area.world:addCollisionClass('Player')
    self.area.world:addCollisionClass('Projectile', {ignores = {'Projectile', 'Player'}})
    self.area.world:addCollisionClass('Collectable', {ignores = {'Collectable', 'Projectile'}})
    self.area.world:addCollisionClass('EnemyProjectile', {ignores = {'EnemyProjectile', 'Projectile', 'Enemy'}})

    self.font = fonts.m5x7_16
    self.director = Director(self)

    self.main_canvas = love.graphics.newCanvas(gw, gh)
    self.player = self.area:addGameObject('Player', gw/2, gh/2)

    self.score = 0
end

function Stage:update(dt)
    self.director:update(dt)

    camera.smoother = Camera.smooth.damped(5)
    camera:lockPosition(dt, gw/2, gh/2)

    self.area:update(dt)
end

function Stage:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
        camera:attach(0, 0, gw, gh)
        self.area:draw()
        camera:detach()

        love.graphics.setFont(self.font)

        -- Score
        love.graphics.setColor(default_color)
        love.graphics.print(self.score, gw - 20, 10, 0, 1, 1, math.floor(self.font:getWidth(self.score)/2), self.font:getHeight()/2)
        love.graphics.setColor(1, 1, 1)

        -- Skill Points
        love.graphics.setColor(skill_point_color)
        love.graphics.print(sp .. 'SP', 20, 10, 0, 1, 1, math.floor(self.font:getWidth(sp)/2), self.font:getHeight()/2)
        love.graphics.setColor(1, 1, 1)

        -- HP
        local r, g, b = unpack(hp_color)
        local hp, max_hp = self.player.hp, self.player.max_hp
        love.graphics.setColor(r, g, b)
        love.graphics.rectangle('fill', gw/2 - 52, gh - 16, 48*(hp/max_hp), 4)
        love.graphics.setColor(r - 0.125, g - 0.125, b - 0.125)
        love.graphics.rectangle('line', gw/2 - 52, gh - 16, 48, 4)
        love.graphics.print('HP', gw/2 - 52 + 24, gh - 24, 0, 1, 1, math.floor(self.font:getWidth('HP')/2), math.floor(self.font:getHeight()/2))
        love.graphics.print(hp .. '/' .. max_hp, gw/2 - 52 + 24, gh - 6, 0, 1, 1, math.floor(self.font:getWidth(hp .. '/' .. max_hp)/2), math.floor(self.font:getHeight()/2))

        -- Cycle
        r, g, b = unpack(default_color)
        love.graphics.setColor(r, g, b)
        love.graphics.setColor(r - 0.125, g - 0.125, b - 0.125)
        love.graphics.rectangle('line', gw/2 + 4, gh - 16, 48, 4)
        love.graphics.print('CYCLE', gw/2 + 28, gh - 24, 0, 1, 1, math.floor(self.font:getWidth('CYCLE')/2), math.floor(self.font:getHeight()/2))

        -- Ammo
        r, g, b = unpack(ammo_color)
        local ammo, max_ammo = self.player.ammo, self.player.max_ammo
        love.graphics.setColor(r, g, b)
        love.graphics.rectangle('fill', gw/2 - 52, 16, 48*(ammo/max_ammo), 4)
        love.graphics.setColor(r - 0.125, g - 0.125, b - 0.125)
        love.graphics.rectangle('line', gw/2 - 52, 16, 48, 4)
        love.graphics.print('AMMO', gw/2 - 52 + 24, 26, 0, 1, 1, math.floor(self.font:getWidth('AMMO')/2), math.floor(self.font:getHeight()/2))
        love.graphics.print(ammo .. '/' .. max_ammo, gw/2 - 52 + 24, 8, 0, 1, 1, math.floor(self.font:getWidth(ammo .. '/' .. max_ammo)/2), math.floor(self.font:getHeight()/2))

        -- Boost
        r, g, b = unpack(boost_color)
        local boost, max_boost = round(self.player.boost, 0), self.player.max_boost
        love.graphics.setColor(r, g, b)
        love.graphics.rectangle('fill', gw/2 + 4, 16, 48*(boost/max_boost), 4)
        love.graphics.setColor(r - 0.125, g - 0.125, b - 0.125)
        love.graphics.rectangle('line', gw/2 + 4, 16, 48, 4)
        love.graphics.print('BOOST', gw/2 + 28, 26, 0, 1, 1, math.floor(self.font:getWidth('BOOST')/2), math.floor(self.font:getHeight()/2))
        love.graphics.print(boost .. '/' .. max_boost, gw/2 + 28, 8, 0, 1, 1, math.floor(self.font:getWidth(boost .. '/' .. max_boost)/2), math.floor(self.font:getHeight()/2))

    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode('alpha')
end

function Stage:destroy()
    self.area:destroy()
    self.area = nil
    self.player = nil
end

function Stage:finish()
    timer:after(1, function()
        gotoRoom('Stage')
    end)
end