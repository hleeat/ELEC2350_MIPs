# FIBONACCI

.data
num: .word 5 # desired index of the Fibonacci sequence
res: .word 0 # the result

.text
# initialize
      la   $s0, num        # desired index
      lw   $a0, 0($s0)     # load word : num
      li   $t0, 1          # current index (counter)
      li   $t1, 1          # n-1
      li   $t2, 1          # n

loop: # find the desired index
      ble  $a0, $t0, end   # found? 
      addi $t0, $t0, 1     # increment counter
      move $t3, $t2        # save $t3 temporarily
      add  $t2, $t2, $t1   # next n
      move $t1, $t3        # next n-1
      b    loop
end:  la   $t5, res        # desired index
      sw   $t2, 0($t5)     # store word : res
