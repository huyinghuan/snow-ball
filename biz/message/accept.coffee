Log = require 'log4slow'
_WeGo = require('wego')
wego = new _WeGo()

Accept =
  parseText: (req, resp, data)->
    console.log 'accept data:', data
    Log.debug data
    serverName = data.ToUserName
    clientName = data.FromUserName
    data.ToUserName = clientName
    data.FromUserName = serverName
    data.Content = "yousay: #{data.Content}"
    wego.sendMsg(req, resp, data)

  parseError: (req, resp)->
    Log.debug req.wego.error
    Log.debug req.wego.data
    resp.send ''

  parseDefault: (req, resp, data)->
    Log.warn "消息未处理"
    Log.info data
    resp.send ''
module.exports = Accept