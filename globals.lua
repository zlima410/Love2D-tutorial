-- Colors
default_color = {0.871, 0.871, 0.871}
background_color = {0.063, 0.063, 0.063}
ammo_color = {0.482, 0.784, 0.643}
boost_color = {0.298, 0.765, 0.851}
hp_color = {0.945, 0.404, 0.271}
skill_point_color = {1, 0.776, 0.365}

default_colors = {default_color, hp_color, ammo_color, boost_color, skill_point_color}
negative_colors = {
    {1-default_color[1], 1-default_color[2], 1-default_color[3]},
    {1-hp_color[1], 1-hp_color[2], 1-hp_color[3]},
    {1-ammo_color[1], 1-ammo_color[2], 1-ammo_color[3]},
    {1-boost_color[1], 1-boost_color[2], 1-boost_color[3]},
    {1-skill_point_color[1], 1-skill_point_color[2], 1-skill_point_color[3]}
}
all_colors = fn.append(default_colors, negative_colors)

attacks = {
    ['Neutral'] = {cooldown = 0.24, ammo = 0, abbreviation = 'N', color = default_color},
    ['Double'] = {cooldown = 0.32, ammo = 2, abbreviation = '2', color = ammo_color},
    ['Triple'] = {cooldown = 0.32, ammo = 3, abbreviation = '3', color = boost_color},
    ['Rapid'] = {cooldown = 0.12, ammo = 1, abbreviation = 'R', color = default_color},
    ['Spread'] = {cooldown = 0.16, ammo = 1, abbreviation = 'RS', color = default_color},
    ['Back'] = {cooldown = 0.32, ammo = 2, abbreviation = 'Ba', color = skill_point_color},
    ['Side'] = {cooldown = 0.32, ammo = 2, abbreviation = 'Si', color = boost_color},
    ['Homing'] = {cooldown = 0.56, ammo = 4, abbreviation = 'H', color = skill_point_color},
}

-- Globals
skill_points = 0

-- Enemies
enemies = {'Rock', 'Shooter'}