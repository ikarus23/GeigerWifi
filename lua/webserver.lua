function initWebserver()
  srv = net.createServer(net.TCP)
  if srv then
    srv:listen(80, function(conn)
      conn:on("receive", handleRequest)
    end)
    return srv
  end
  return nil
end


function handleRequest(sck, request)
  -- Parse request.
  local _, _, method, path, vars =
      string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
  if(method == nil)then
    _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
  end
  local get = {}
  if (vars ~= nil)then
    for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
      get[k] = v
    end
  end

  -- Create static response. Parameters are ignored.
  local response = {"HTTP/1.0 200 OK\r\nServer: NodeMCU on ESP8266\r\nContent-Type: text/html\r\n\r\n"}
  response[#response + 1] = "<!DOCTYPE html><html><head>"
  response[#response + 1] = "<title>Geiger Wifi</title>"
  response[#response + 1] = "<meta http-equiv=\"refresh\" content=\"3\">"
  response[#response + 1] = "</head><body>" 
  response[#response + 1] = CURRENT_GEIGER_DATA
  response[#response + 1] = "</body></html>"

  -- Sends and removes the first element from the 'response' table.
  local function send(localSocket)
    if #response > 0 then
      localSocket:send(table.remove(response, 1))
    else
      localSocket:close()
      response = nil
    end
  end

  -- Triggers the send() function again once the first chunk of
  -- data was sent.
  sck:on("sent", send)
  send(sck)
end
