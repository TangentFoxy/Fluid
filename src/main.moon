Fluid = require "Fluid"
Mix = require "Mix"

volume = 4.2e12
air = { nitrogen: 0.775, oxygen: 0.21, argon: 0.01, co2: 0.005 }
earth = Fluid(volume)
for type, amount in pairs air
  earth\add type, volume * amount

-- print "pressure", earth\pressure!
-- for type, amount in pairs earth.contents
--   print type, earth\percent(type), amount

ship = Fluid 600
for type, amount in pairs air
  ship\add type, 600 * amount

h2tank = Fluid 40
h2tank\add "hydrogen", 40 * 6 -- volume * desired pressure
o2tank = Fluid 20
o2tank\add "oxygen", 20 * 12
mixes = { Mix(ship, h2tank), Mix(ship, o2tank) }

mixing = false
time,frequency = 0, 1/60
love.update = (dt) ->
  if mixing
    time += dt
    if time >= frequency
      time -= frequency
      for mix in *mixes
        mix\update 10

colors = {
  hydrogen: { 1, 1, 0, 1 }
  oxygen: { 0, 0, 1, 1 }
  nitrogen: { 0, 1, 1, 1 }
  argon: { 1, 0, 0, 1 }
  co2: { 0.5, 0.5, 0.5, 1 }
}

w = love.graphics.getWidth!
h = love.graphics.getHeight!
h2 = h / 2
love.draw = ->
  y = -25
  for type in pairs ship.contents
    percent = ship\percent type
    love.graphics.setColor colors[type]
    love.graphics.rectangle "fill", 0, h2 + y, percent * w, 10
    y += 10
  y = 0
  for type in pairs h2tank.contents
    percent = h2tank\percent type
    love.graphics.setColor colors[type]
    love.graphics.rectangle "fill", 0, y, percent * w, 10
    y += 10
  y = 10
  for type in pairs o2tank.contents
    percent = o2tank\percent type
    love.graphics.setColor colors[type]
    love.graphics.rectangle "fill", 0, h - y, percent * w, 10
    y += 10

love.keypressed = (key) ->
  love.event.quit! if key == "escape"
  mixing = not mixing if key == "space"
