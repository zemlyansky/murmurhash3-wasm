var M = require('./murmur3.wasm')({
  imports: {
    console: {
      log: function (x) {
        x = x >>> 0
        console.log('Value: ', x, '0x' + x.toString(16).toUpperCase())
      }
    }
  }
})

var murmurWasm32 = M.exports.murmur3_32
var mem = new Uint8Array(M.exports.mem.buffer)

function hash32 (key, seed = 0) {
  var len = key.length
  for (var i = 0; i < len; i++) {
    mem[i] = key.charCodeAt(i)
  }
  return murmurWasm32(len, seed) >>> 0
}

module.exports = { hash32 }
