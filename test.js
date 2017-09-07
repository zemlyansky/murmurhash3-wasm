var ava = require('ava')
var m = require('.')
var k = [
  ['', 0],
  ['0', 3530670207],
  ['01', 1642882560],
  ['012', 3966566284],
  ['0123', 3558446240],
  ['01234', 433070448],
  ['Orange', 1637794643],
  ['Ensemble-based online learning algorithm', 1450795871],
  ['^123438*&6345sjfu25', 3023040079]
]

k.forEach((pair) => {
  ava('Key: ' + pair[0], (t) => {
    t.is(m.hash32(pair[0]), pair[1])
  })
})

/*
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
*/
