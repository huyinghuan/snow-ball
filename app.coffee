express = require 'express'
app = express()
port = require('./config.json').port
Log = require './log'
bodyParser = require 'body-parser'
app.use(bodyParser())

app.get('/', (req, res)->
  Log.info req.param 'signature'
  res.send('hello world')
)

app.listen port

Log.success "正在运行: http://localhost:#{port}"