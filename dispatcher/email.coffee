_nodemailer = require 'nodemailer'
_smtpTransport = require 'nodemailer-smtp-transport'
_WeGo = require('wego')
wego = new _WeGo()

config = require '../config'

_smtp = config.mail

transport = _nodemailer.createTransport(_smtpTransport(_smtp))

send = (msg, done)->
  standardEMail(msg)
  transport.sendMail(msg, done)

standardEMail = (msg)->
  msg.from = _smtp.auth.user
  msg.subject = msg.subject or "No title"
  msg

module.exports = (req, resp, data)->
  userContent = data.Content
  serverName = data.ToUserName
  clientName = data.FromUserName
  data.ToUserName = clientName
  data.FromUserName = serverName
  data.Content = "yousay: #{data.Content}"


  arr = userContent.split('|')
  mailTo = arr[1]
  subject = arr[2]
  content = arr[3]
  msg =
    from: _smtp.auth.user
    to: mailTo
    subject: subject
    html: content
  send(msg, (error, info)->
    if not error
      data.Content = "邮件发送成功"
    else
      data.Content = "邮件发送失败:#{JSON.stringify(error)}"
    wego.sendMsg(req, resp, data)
  )
