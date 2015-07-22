_WeGo = require('wego')
wego = new _WeGo()
_helpQueue = require '../help.json'
module.exports = (req, resp, data)->
  serverName = data.ToUserName
  clientName = data.FromUserName
  data.ToUserName = clientName
  data.FromUserName = serverName
  data.Content = _helpQueue.join("\n")
  wego.sendMsg(req, resp, data)