lui	$s0,0x2350
ori	$s0,0xAAAA



li $s0,3
li $s1,-48
addi	$t5,$0,2
xori	$t7,$t5,3
addi	$t0,$0,1
sra	$t1,$s1,3
slt	$t2,$s0,$0
bne	$t2,$0,else
sllv 	$t3,$t0,$s0
add	$s2,$t1,$t3
j 	exit
else:	add	$t3,$0,$0
	add	$s2,$t1,$t3
	j	exit
exit:
	

