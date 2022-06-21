# Term: 2021 Spring
# ELEC 2350 Computer Organization
# Project 1
# Processing of a 5x5 array
	.data
# Assume your student ID is 20670332
# Please replace the digits in the arrayA corresponding to your student ID
arrayA:
arrayA_0:	.word 2 0 6 7 0
arrayA_1:	.word 0 6 7 0 3
arrayA_2:	.word 6 7 0 3 3
arrayA_3:	.word 7 0 3 3 2
arrayA_4:	.word 0 3 3 2 2

col_avg:
col_0_avg:	.word 0
col_1_avg:	.word 0
col_2_avg:	.word 0
col_3_avg:	.word 0
col_4_avg:	.word 0

avg_value:	.space 4

msg0:		.asciiz "row number: "
msg1:		.asciiz "col number: "
msg2:		.asciiz "The number is "
msg3:		.asciiz "Average of col "
msg4:		.asciiz "Average of the 5x5 array: "
colon:		.asciiz ": "
newline:	.asciiz "\n"

	.text
main:
#----	----------------------------------------------------
#
# Write your code here
	addi	$t2,$0,5	#count_col=5
	addi	$t3,$0,5	#count_row=5
	addi	$s3,$0,0	#set 0
	la	$s0,arrayA	#load the address of arrayA
	la	$s1,col_avg	#load the address of col_avg
	la 	$s2,avg_value	#load the address of avg_value
	lw	$s4,0($s2)	#get the avg_value
	
	la	$a0,msg0	#print "row number: "
	li	$v0,4
	syscall
	
	li	$v0,5		#input row
	syscall
	move	$t0,$v0
	
	la	$a0,msg1	#print "col number: "
	li	$v0,4
	syscall
	
	li	$v0,5		#input col
	syscall
	move	$t1,$v0
	
	la	$a0,msg2	#print "The number is "
	li	$v0,4
	syscall
	
	mul	$t4,$t0,$t2	#r=row*count_col
	add	$t4,$t4,$t1	#r=r+col
	sll	$t4,$t4,2	#multiply by 4
	add	$t4,$t4,$s0	#add base+offset	
	lw	$t5,($t4)	#get arraA[row][col]
	
	li	$v0,1		#print arrayA[row][col]
	move	$a0,$t5
	syscall
	
	li $v0, 4		#print newline
    	la $a0, newline
    	syscall
	
	addi 	$t0,$0,0	#set i=0
	addi	$t1,$0,0,	#set j=0
	
for1:	beq	$t0,$t3,Av	#if i==5 go to Av
	beq	$t1,$t2,for2	#if j==5 go to for2
	mul	$t4,$t0,$t2	#r=i*count_col
	add	$t4,$t4,$t1	#r=r+j
	sll	$t4,$t4,2	#multiply by 4
	add	$t4,$t4,$s0	#add base+offset	
	lw	$t5,($t4)	#get arraA[i][j]
	
	sll	$t6,$t0,2	#multiply by 4
	add	$t6,$t6,$s1	#add base+offset
	lw	$t7,($t6)	#get col_avg[i]=$t7
	add	$t8,$t7,$t5	#add col_avg[i]+arrayA[i][j]
	add	$s3,$s3,$t8	#add col_avg[i]=col_avg[i]+arrayA[i][j]
	add	$t1,$t1,1	#increment j
	j	for1		#go to loop for1
	
		
	
for2:	beq	$t0,$t3,Av	#if i==count_row->go to Av
	add	$s4,$s4,$s3	#avg_value=avg_value+col_avg[i]
	div	$s3,$t3		#divide col_avg[i]/5
	mflo	$s3		#col_avg[i]=col_avg[i]/5
	
	la	$a0,msg3	#print "Average of col "
	li	$v0,4
	syscall
	li	$v0,1		#print i
	move	$a0,$t0
	syscall
	
	li $v0, 4		#print colon
    	la $a0, colon
    	syscall
	
	li	$v0,1		#print col_avg[i]
	move	$a0,$s3		
	syscall
	
	li $v0, 4		#print newline
    	la $a0, newline
    	syscall
	
	sw	$s3,($t6)	#store col_avg[i]
	addi	$t0,$t0,1	#increment i
	add	$t1,$0,$0	#initialize j=0	
	add	$s3,$0,$0	#initialize $s3=0
	j	for1
	
Av:	mul	$t7,$t2,$t3	#count_row*count_col=25
	div	$s4,$t7		#divide avg_value/25
	mflo	$s4		#the quotient=$s4->avg_value=avg_value/25
	sw	$s4,0($s2)	#store avg_value
	
	la	$a0,msg4	#print "Average of the 5x5 array: "
	li	$v0,4
	syscall
	
	li	$v0,1		#print avg_value
	move	$a0,$s4
	syscall		
	
	
#	
#--------------------------------------------------------
# Terminate the program
	li	$v0, 10
	syscall

