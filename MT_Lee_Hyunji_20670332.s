# ELEC2350 (2020/21 Fall) ?? Introduction to Computer Organization and Design
# Midterm Project
	.data 
# Your Student ID is XXXXXXXX
# It is randomly stored into array "stdid"
stdid:	.word	2,2,0,6,7,0,3,3
msg0:	.asciiz "Enter the pattern size (from 1 to 10): "
nline:	.asciiz	"\n"
spc:	.asciiz	" "

	.text
main:
# Print the string "Enter the pattern size (from 1 to 10):" to the MARS I/O console
	la	$a0, msg0
	li	$v0, 4
	syscall
# Read and save user input from the MARS I/O console into register $v0
	li	$v0, 5
	syscall
# --------------------------------------------------------------------	
#
#  Write your code here
	
	move	$s0,$v0 #s0에 $v0값 즉 a값 구한거임
	li	$s1,0#t=0
	li	$s2,0#i=0
	li	$s7,8
	la	$s4, stdid  #load word from data section to the $s4
	addi	$s1,$s1,1 #set t=1
Loop:	mul	$t0,$s0,$s0
	beq	$s2,$t0,Exit
	rem 	$t3,$s2,$s0
	bne	$t3,$0,ElseIf
	jal	print1
	jal	print
	jal	print2
	
	bne	$s1,$s7,Move  #t==8 t=0
	move	$s1,$0
	

	
ElseIf:	slt	$t5,$s2,$s0
	beq	$t5,$0,ElseIf1
	jal	print
	jal 	print2
	bne	$s1,$s7,M1  #t==8 t=0
	move	$s1,$0
M1:	#addi	$s2,$s2,1
	mul	$t6,$s0,$s0
	slt	$t7,$s2,$t6
	addi	$s2,$s2,1
	bne	$t7,$0,Loop
	
ElseIf1:div	$t3,$s2,$s0
	rem	$t4,$s2,$s0
	bne 	$t3,$t4,Else
	jal	print
	jal	print2
	bne	$s1,$s7,M2  #t==8 t=0
	move	$s1,$0
M2:	#addi	$s2,$s2,1
	mul	$t6,$s0,$s0
	slt	$t7,$s2,$t6
	addi	$s2,$s2,1
	bne	$t7,$0,Loop
 

Else:	jal	print2
	jal	print2 

	bne	$s1,$s7,M3  #t==8 t=0
	move	$s1,$0
M3:	#addi	$s2,$s2,1
	mul	$t6,$s0,$s0
	slt	$t7,$s2,$t6
	addi	$s2,$s2,1
	bne	$t7,$0,Loop
	
print:	
	sll	$s3,$s1,2
	add	$s3,$s3,$s4
	lw	$s5,0($s3)
	addi	$s1,$s1,1
	li	$v0,1
	add	$a0,$zero,$s5
	syscall
	jr	$ra
print1:
	li	$v0,4
	la	$a0,nline
	syscall
	jr	$ra
print2:	
	li	$v0,4
	la	$a0,spc
	syscall
	jr	$ra
Move:	#addi	$s2,$s2,1
	mul	$t6,$s0,$s0
	slt	$t7,$s2,$t6
	addi	$s2,$s2,1
	bne	$t7,$0,Loop
Exit:
#
# --------------------------------------------------------------------	
# Terminate the program
	li	$v0, 10
	syscall
