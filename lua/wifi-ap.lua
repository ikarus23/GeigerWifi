require("config")

WIFI_IS_CLIENT = false

print("Set up wifi as AP.")
cfg={}
cfg.ssid = SSID
cfg.pwd = PASSWORD
cfg.auth = AUTH
wifi.ap.config(cfg)
wifi.setmode(wifi.SOFTAP)

print("Config done.")
print("You have 10 seconds to abort Startup.")
print("Waiting...")
tmr.alarm(0,10000,0,startup)
