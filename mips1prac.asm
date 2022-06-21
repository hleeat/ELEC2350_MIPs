li $t0,10
jal SqSum #takes argument in t0

move $a0,$v0 #return result in t1
li $v0,1
syscall

li $v0,10
syscall


SqSum :
	addi $sp, $sp, -8
	subu $sp,$sp,4 # point to the place for the new item,
	sw $t0,($sp) # store the contents of $t0 as the new top.
	subu $sp,$sp,4 # point to the place for the new item,
	sw $ra,($sp) # store the contents of $ra as the new top.

	beq $t0,$0,elsePart
ifPart:
	addi $t0,$t0,-1
	jal SqSum
	add $t0,$t0,1 #restore t0
	mul $t2,$t0,$t0 #get s^2
	add $v0,$v0,$t2 #get s^2 and add

	j exit

elsePart:
	move $v0,$t0
exit:
	lw $ra,($sp) # store the contents of $ra as the new top.
	addu $sp,$sp,4 # point to the place for the new item,
	lw $t0,($sp) # store the contents of $ra as the new top.
	addu $sp,$sp,4 # point to the place for the new item,
	addi $sp, $sp, 8
	jr $ra