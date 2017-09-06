(module
  (import "console" "log" (func $log (param i32)))
  (memory $mem (export "mem") 1)
  (func $murmur3_32 (export "murmur3_32") (param $len i32) (param $seed i32) (result i32)
    (local $c1 i32)
    (local $c2 i32)
    (local $r1 i32)
    (local $r2 i32)
    (local $m i32)
    (local $n i32)
    (local $k i32)
    (local $hash i32)
    (local $nblocks i32)
    (local $tail i32)
    (local $i i32)
    (local $rem i32)

    (set_local $c1 (i32.const 0xcc9e2d51))
    (set_local $c2 (i32.const 0x1b873593))
    (set_local $r1 (i32.const 15))
    (set_local $r2 (i32.const 13))
    (set_local $m (i32.const 5))
    (set_local $n (i32.const 0xe6546b64))
    (set_local $hash (get_local $seed))
    (set_local $nblocks (i32.div_s (get_local $len)(i32.const 4))) ;; number of blocks
    (set_local $tail (i32.mul (get_local $nblocks)(i32.const 4)))
    (set_local $i (i32.const 0))

    ;; Process each full 4-byte chunk of key
    (if (i32.ne (get_local $nblocks)(i32.const 0)) (then
      (loop $process
        ;; k ← one fourByteChunk
        (set_local $k (i32.load (get_local $i)))
        ;; k ← k × c1
        (set_local $k (i32.mul (get_local $k)(get_local $c1)))
        ;; k ← (k ROL r1)
        (set_local $k 
          (i32.or
              (i32.shl (get_local $k)(i32.const 15))
              (i32.shr_u (get_local $k)(i32.const 17))
          )
        )
        ;; k ← k × c2
        (set_local $k (i32.mul (get_local $k)(get_local $c2)))
        ;; hash ← hash XOR k
        (set_local $hash (i32.xor (get_local $hash)(get_local $k)))
        ;; hash ← (hash ROL r2)
        (set_local $hash
          (i32.or
              (i32.shl (get_local $hash)(i32.const 13))
              (i32.shr_u (get_local $hash)(i32.const 19))
          )
        )
        ;; hash ← hash × m + n
        (set_local $hash
          (i32.add 
            (i32.mul (get_local $hash)(get_local $m))
            (get_local $n)
          )
        )
        (set_local $i (i32.add (get_local $i)(i32.const 4)))
        (br_if $process (i32.lt_s (get_local $i)(get_local $tail)))
      )
    ))
    ;; k ← 0
    (set_local $k (i32.const 0))
    ;; rem - remainder (x % 4 ~ x & 00000011 ~ x & 3)
    (set_local $rem (i32.and (get_local $len)(i32.const 3)))

    ;; rem === 3 ?
    ;; (br_if $bl3 (i32.eq (get_local $rem)(i32.const 3)))
    ;; rem === 2 ? 
    ;; (br_if $bl2 (i32.eq (get_local $rem)(i32.const 2)))
    ;; rem === 1 ?
    ;; (br_if $bl1 (i32.eq (get_local $rem)(i32.const 1)))
    ;; rem === 0 ?
    ;; (br_if $bl0 (i32.eq (get_local $rem)(i32.const 0)))

    ;; k ^= (tail[2] << 16)
    (if (i32.eq (get_local $rem)(i32.const 3)) (then
      (set_local $k (i32.xor
        (get_local $k)
        (i32.shl 
          (i32.load8_u (i32.add (get_local $tail)(i32.const 2)))
          (i32.const 16)
        )
      ))
    ))

    ;; k ^= (tail[1] << 8)
    (if (i32.ge_s (get_local $rem)(i32.const 2)) (then
      (set_local $k (i32.xor
        (get_local $k)
        (i32.shl 
          (i32.load8_u (i32.add (get_local $tail)(i32.const 1)))
          (i32.const 8)
        )
      ))
    ))

    (if (i32.ge_s (get_local $rem)(i32.const 1)) (then
      (set_local $k (i32.xor
        (get_local $k)
        (i32.load8_u (get_local $tail))
      ))
      ;; k ← k × c1
      (set_local $k (i32.mul (get_local $k)(get_local $c1)))
      ;; k ← (k ROL r1)
      (set_local $k 
        (i32.or
            (i32.shl (get_local $k)(i32.const 15))
            (i32.shr_u (get_local $k)(i32.const 17))
        )
      )
      ;; k ← k × c2
      (set_local $k (i32.mul (get_local $k)(get_local $c2)))
      ;; hash ← hash XOR k
      (set_local $hash (i32.xor (get_local $hash)(get_local $k)))
    ))

    (set_local $hash (i32.xor (get_local $hash)(get_local $len)))
    (set_local $hash (i32.xor (get_local $hash)(i32.shr_u (get_local $hash)(i32.const 16))))
    (set_local $hash (i32.mul (get_local $hash)(i32.const 0x85ebca6b)))
    (set_local $hash (i32.xor (get_local $hash)(i32.shr_u (get_local $hash)(i32.const 13))))
    (set_local $hash (i32.mul (get_local $hash)(i32.const 0xc2b2ae35)))
    (set_local $hash (i32.xor (get_local $hash)(i32.shr_u (get_local $hash)(i32.const 16))))

    ;; (call $log (get_local $hash))
    (get_local $hash)
  )
)
