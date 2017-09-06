var m = require('./index')

if (
  (m.hash32('') === 0) &&
  (m.hash32('0') === 3530670207) &&
  (m.hash32('01') === 1642882560) &&
  (m.hash32('012') === 3966566284) &&
  (m.hash32('0123') === 3558446240) &&
  (m.hash32('01234') === 433070448) &&
  (m.hash32('', 1) === 1364076727)
) {
  console.log('Everything is fine')
} else {
  console.log('Algorithm error')
}
