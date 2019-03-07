class Mix
  new: (@high, @low, @volume=1) =>
  update: (dt) =>
    a, b = @high\pressure!, @low\pressure!
    if b > a
      tmp = @high
      @high = @low
      @low = tmp
      tmp = a
      a = b
      b = tmp
    elseif a > b
      @active = true
    else
      @active = false

    -- print "High: #{a}", "Low: #{b}", "Active? #{@active}"
    if @active
      sum = (a - b) * @volume * dt
      for type, amount in pairs @high.contents
        tmp = sum * @high\percent type
        -- print "Moving #{tmp} #{type}.."
        @high\remove type, tmp
        @low\add type, tmp
