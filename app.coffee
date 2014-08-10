express = require 'express'
app = express()
port = require('./config.json').port
token = require('./config.json').token
Log = require 'log4slow'
bodyParser = require 'body-parser'


_signature = require './biz/utils/signature'

app.use(bodyParser())

app.get('/', (req, res)->
  #威信加密后的字符串
  signature = req.param 'signature'
  #时间戳
  timestamp = req.param 'timestamp'
  #随机数
  nonce = req.param 'nonce'
  #随机字符串
  echostr = req.param 'echostr'
  #认证校验
  flag = _signature(timestamp, nonce, token, signature)

  res.send(echostr) if flag
  res.send('error')

)

app.listen port

Log.info "正在运行: http://localhost:#{port}"