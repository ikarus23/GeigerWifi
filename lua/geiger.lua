SHOW_GEIGER = true
CURRENT_GEIGER_DATA = ""

function initGeigerUart()
  -- Activate "poor mans ground" on D0.
  gpio.mode(0, gpio.OUTPUT)
  gpio.write(0, gpio.LOW)
  uart.alt(1)
  uart.setup(0, 9600, 8, uart.PARITY_NONE, uart.STOPBITS_1, 0)
  -- Add the callback to the new UART with a delay.
  -- I don't know why, but without delay it will fail.
  tmr.alarm(1, 1000, tmr.ALARM_SINGLE,
    function()
      uart.on("data", "\n", onDataGc, 0)
    end)
end 

function onDataGc(data)
  if SHOW_GEIGER then
    values = split(data, ", ")
    CURRENT_GEIGER_DATA =
      values[5]..": "..values[6].."<br>"..
      values[3]..": "..values[4].."<br>"..
      values[1]..": "..values[2].."<br>"..
      "Mode: "..values[7]
    printOledText(values[5]..": "..values[6], values[3]..":    "..values[4],
        values[1]..":    "..values[2], "Mode:   "..values[7])
  end
end

function split(data, sep)
  sep, fields = sep or ",", {}
  pattern = string.format("([^%s]+)", sep)
  data:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end
