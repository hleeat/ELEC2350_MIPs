main:	addi	$a3,$0,4803
	addi	$a2,$0,0
	jal 	f
	j	exit
f:	slt	$t0,$a3,$0
	bne	$t0,$0,else
	srl	$t1,$a3,8
	sll	$t1,$t1,8
	sub	$t2,$a3,$t1
	sub	$a2,$a2,$t2
	jr	$ra
else:	sub	$t1,$0,$a3
	srl	$t2,$t1,8
	sll	$t2,$t2,8
	sub	$t2,$t1,$t2
	sub	$t2,$0,$t2
	sub	$a2,$a2,$t2
	jr 	$ra
exit: