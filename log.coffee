colors = require 'colors'

colors.setTheme
  info: 'green'
  help: 'cyan'
  warn: 'yellow'
  debug: 'blue'
  error: 'red'

Log = {}

factory = (type)->
  (content)->
    return if content
    console.log content[type]

Log.warn = factory 'warn'
Log.error = factory 'error'
Log.info = factory 'info'
Log.success = factory 'help'

module.exports = Log