[![Build Status](https://travis-ci.org/zemlyansky/murmurhash3-wasm.svg?branch=master)](https://travis-ci.org/zemlyansky/murmurhash3-wasm)

MurmurHash3-wasm
================

**A WebAssembly implementation of [MurmurHash3](http://code.google.com/p/smhasher/source/browse/trunk/MurmurHash3.cpp?spec=svn145&r=144)'s hashing algorithms.**

Usage
=====
```javascript
  var mmh3wasm = require("murmurhash3js")
  var key = 'Orange'
  var seed = 0
  mmh3wasm.hash32(key, seed) // 1637794643
```
