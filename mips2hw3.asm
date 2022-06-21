li $a0,10
jal SqSum #takes argument in t0

move $a0,$v0 #return result in t1
li $v0,1
syscall

li $v0,10
syscall

SqSum:	addi $sp,$sp,-8
	sw	$ra,4($sp)
	sw	$a0,0($sp)
	beq	$a0,$0,L3
L1:	addi	$a0,$a0,-1
	addi	$a0,$a0,2
	jal	SqSum
	addi	$a0,$a0,1
	add	$t1,$0,$0
L2:	add	$t2,$a0,$a0
	addi	$t1,$t1,1
	bne	$t1,$a0,L2
	add	$v0,$v0,$t2
	j	exit
L3:	addu	$v0,$a0,$0
exit:	lw	$a0,0($sp)
	lw	$ra,4($sp)
	addi	$sp,$sp,8
	jr 	$ra
