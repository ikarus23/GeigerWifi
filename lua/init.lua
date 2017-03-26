function startup()
  if file.open("init.lua") == nil then
    print("init.lua deleted")
  else
    print("Launching main application.")
    file.close("init.lua")
    dofile("application.lua")
  end
end

-- Run as wifi client or AP?
-- (Both of them will call startup() when finished.)
dofile("wifi-client.lua")
-- There is a bug that breaks DHCP in station mode.
-- (https://github.com/nodemcu/nodemcu-firmware/issues/1577)
-- The ESP8266 will not be rechable (not even ping) and therefore
-- accessing the webserver will not be possible.
--dofile("wifi-ap.lua")
