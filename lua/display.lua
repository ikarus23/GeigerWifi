-- Hardware: 
--   ESP-12E Devkit
--   4 pin I2C OLED 128x64 Display Module
-- Connections:
--   ESP  --  OLED
--   3v3  --  VCC
--   GND  --  GND
--   D1   --  SDA
--   D2   --  SCL

-- Variables 
SDA = 1 -- SDA Pin
SCL = 2 -- SCL Pin

TITLE = ""
LINE1 = ""
LINE2 = ""
LINE3 = ""
LINE4 = ""


function initOLED()
  sla = 0x3C
  i2c.setup(0, SDA, SCL, i2c.SLOW)
  disp = u8g.ssd1306_128x64_i2c(sla)
  disp:setFont(u8g.font_6x10)
  disp:setFontRefHeightExtendedText()
  disp:setDefaultForegroundColor()
  disp:setFontPosTop()
end

function printOledPage(title, line1, line2, line3, line4)
  disp:firstPage()
  repeat
    disp:drawStr(0, 0, title)
    disp:drawHLine(0, 13, 125)
    disp:drawStr(0, 18, line1)
    disp:drawStr(0, 30, line2)
    disp:drawStr(0, 42, line3)
    disp:drawStr(0, 54, line4)
  until disp:nextPage() == false
end

function printOledTitle(title)
  TITLE = title
  printOledPage(TITLE, LINE1, LINE2, LINE3, LINE4)
end

-- Pass "nil" to skip updating that line.
function printOledText(line1, line2, line3, line4)
  if line1 then
    LINE1 = line1
  end
  if line2 then
    LINE2 = line2
  end
  if line3 then
    LINE3 = line3
  end
  if line4 then
    LINE4 = line4
  end
  printOledPage(TITLE, LINE1, LINE2, LINE3, LINE4)
end

function clearOledText()
  LINE1 = ""
  LINE2 = ""
  LINE3 = ""
  LINE4 = ""
  printOledPage(TITLE, LINE1, LINE2, LINE3, LINE4)
end
