_crypto = require 'crypto'

Log = require 'log4slow'
module.exports = (timestamp, nonce, token, signature)->
  arr = [token, timestamp, nonce]
  str = arr.sort().join('')
  shasum = _crypto.createHash 'sha1'
  shasum.update str
  sha1 = shasum.digest('hex')
  Log.info [sha1, signature, arr]
  sha1 is signature