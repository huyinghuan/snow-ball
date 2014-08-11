Log = require 'log4slow'
class Accept
  constructor: ->

  parseText: (req, resp, data)->
    Log.debug data
    resp.send ''

  parseError: (req, resp)->
    Log.debug req.weixin.error
    Log.debug req.weixin.data
    resp.send ''

  parseDefault: (req, resp, data)->
    Log.warn "消息未处理"
    Log.info data
    resp.send ''
module.exports = new Accept()