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
      获取天气: \n
        发送 -w 或者 天气 或者 -weather 即可获取（默认是长沙）\n
        获取指定城市发送  天气|北京    即可
      "
  wego.sendMsg(req, resp, data)