express = require 'express'
app = express()
port = require('./config.json').port
token = require('./config.json').token

Log = require 'log4slow'

_WeGo = require 'wego'

app.use(express.static(__dirname + '/static'))

acceptHandle = require './biz/message/accept'

weixin = new _WeGo(token, acceptHandle)

app.get('/', (req, res)->
  echostr = weixin.veritySignature(req)
  if echostr then res.send(echostr) else res.send('error')
)

app.post('/', (req, res)->
  weixin.parse(req, res)
)

app.listen port

Log.info "正在运行: http://localhost:#{port}"