_WeGo = require('wego')
wego = new _WeGo()

module.exports = (req, resp, data)->
  serverName = data.ToUserName
  clientName = data.FromUserName
  data.ToUserName = clientName
  data.FromUserName = serverName
  data.Content = "
      发送邮件格式: \n
        email|email-address|title|content
      "
  wego.sendMsg(req, resp, data)