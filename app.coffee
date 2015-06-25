express = require 'express'
app = express()
port = require('./config.coffee').port
token = require('./config.coffee').token

Log = require 'log4slow'

_WeGo = require 'wego'

acceptHandle = require './biz/message/accept'

wego = new _WeGo(token, acceptHandle)

app.get('/', (req, res)->
  echostr = wego.veritySignature(req)
  if echostr then res.send(echostr) else res.send('error')
)

app.post('/', (req, res)->
  wego.parse(req, res)
)

app.listen port

Log.info "正在运行: http://localhost:#{port}"