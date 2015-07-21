path = require 'path'
fs = require 'fs'

getMessageType = (str)->
  arr = str.split("|")
  type = arr[0]
  switch type
    when '-e', 'email' then return "email"
    when '-h','--help' then return "help"
  return type


module.exports = (req, resp, data)->
  content = data.Content
  type = getMessageType(content)
  filePath = path.join(__dirname, type)

  isExists = fs.existsSync("#{filePath}.coffee") or fs.existsSync("#{filePath}.js")
  if not isExists
    filePath = path.join(__dirname, "undefined-msg")

  fn = require(filePath)

  fn(req, resp, data)