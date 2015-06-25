_WeGo = require('wego')
wego = new _WeGo()

module.exports = (req, resp, data)->
  serverName = data.ToUserName
  clientName = data.FromUserName
  data.ToUserName = clientName
  data.FromUserName = serverName
  wego.sendMsg(req, resp, data)