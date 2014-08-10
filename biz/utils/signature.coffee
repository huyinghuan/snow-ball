_crypto = require 'crypto'
shasum = _crypto.createHash 'sha1'
Log = require 'log4slow'
#timestamp, nonce, token, signature
#1407678355 1961868584 huyinghuan ec2c8a63b49a8350250a4ba06dd88054f85611ee
module.exports = (timestamp, nonce, token, signature)->
  arr = [token, timestamp, nonce]
  str = arr.sort().join('')
  shasum.update str
  sha1 = shasum.digest('hex')
  Log.info sha1
  Log.debug signature
  sha1 is signature