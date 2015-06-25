Log = require 'log4slow'

_dispatcher = require '../../dispatcher/index'

Accept =
  parseText: (req, resp, data)->
    _dispatcher(req, resp, data)

  parseError: (req, resp)->
    Log.debug req.wego.error
    Log.debug req.wego.data
    resp.send ''

  parseDefault: (req, resp, data)->
    Log.warn "消息未处理"
    Log.info data
    resp.send ''

module.exports = Accept