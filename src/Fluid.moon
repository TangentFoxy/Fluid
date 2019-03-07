class Fluid
  new: (@volume=1) =>
    @contents = {}
    @sum = 0
  add: (type, amount) =>
    @contents[type] = 0 unless @contents[type]
    @contents[type] += amount
    @sum += amount
  remove: (type, amount) =>
    @contents[type] = 0 unless @contents[type]
    @contents[type] -= amount
    @sum -= amount
  pressure: =>
    return @sum / @volume
  percent: (type) =>
    return 0 unless @contents[type]
    return @contents[type] / @sum
  amount: =>
    return @contents[type] or 0
