-- Main Program 
require("display")
require("geiger")
require("webserver")

-- Init the display.
initOLED()
printOledTitle("    Geiger Wifi")
printOledText("* WiFi up and running", nil, nil, nil)


-- Run Webserver.
srv = initWebserver()
printOledText(nil, "* Webserver running", nil, nil)


-- Connect to geiger counter.
SHOW_GEIGER = false
initGeigerUart()
printOledText(nil, nil, "* Reading data from", "  Geiger Counter")


-- Finished Init Toggle view.
function toggleView(timer)
  if SHOW_GEIGER == false then
    SHOW_GEIGER = true
    tmr.alarm(2, 20000, tmr.ALARM_SINGLE, toggleView)
  else
    SHOW_GEIGER = false
    printOledText("Connect to the", "SSID '"..SSID .."'",
        "and access the page", nil)
    if WIFI_IS_CLIENT then
      printOledText(nil, nil, nil, "http://"..wifi.sta.getip())
    else
      ip = wifi.ap.getip()
      printOledText(nil, nil, nil, "http://"..ip)
    end
    tmr.alarm(2, 3000, tmr.ALARM_SINGLE, toggleView)
  end
end
tmr.alarm(2, 2000, tmr.ALARM_SINGLE, toggleView)
