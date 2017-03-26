require("config")

WIFI_IS_CLIENT = true

wifi.sta.disconnect()
print("Set up wifi as client for SSID '"..SSID.."'.")
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID,PASSWORD)
tmr.alarm(1, 1000, 1, function() 
  if wifi.sta.getip()== nil then 
    print("IP unavaiable, Waiting...") 
  else 
    tmr.stop(1)
    print("Config done, IP is "..wifi.sta.getip()..".")
    print("You have 10 seconds to abort Startup.")
    print("Waiting...")
    tmr.alarm(0,10000,0,startup)
  end 
end)
