_crypto = require 'crypto'
shasum = _crypto.createHash 'sha1'
Log = require 'log4slow'
module.exports = (timestamp, nonce, token, signature)->
  arr = [token, timestamp, nonce]
  str = arr.sort().join('')
  shasum.update str
  sha1 = shasum.digest('hex')
  Log.info sha1, signature
  sha1 is signature
