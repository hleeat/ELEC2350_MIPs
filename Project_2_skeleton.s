# ELEC2350 2021 Spring
# Project 2 - Find Me if You Can
.eqv	c_range_xy	10
	.data
seed:	.word 13207
msg:	.asciiz "Please enter a number: "
msg0:	.asciiz "What is the x coordinate of the treasure (0-9)? "
msg1:	.asciiz "What is the y coordinate of the treasure (0-9)? "
msg2:	.asciiz "The x coordinate of the treasure is larger than your guess. ("
msg3:	.asciiz "The x coordinate of the treasure is smaller than your guess. ("
msg4:	.asciiz "The x coordinate of the treasure is correct. ("
msg5:	.asciiz "The y coordinate of the treasure is larger than your guess. ("
msg6:	.asciiz "The y coordinate of the treasure is smaller than your guess. ("
msg7:	.asciiz "The y coordinate of the treasure is correct. ("
msg8:	.asciiz "You get the treasure!!! ("
msg9: 	.asciiz "Do you want to continue?? (0:No, stop the game.  1:Yes, play again.) "
msg10:	.asciiz "Wrong message! Please enter either (0) or (1)!!!!\n"
msg11:	.asciiz "Play with me next time. See YOU!!\n"
msg12:	.asciiz "Out of Range!!\n"
c_bkt:	.asciiz ")\n"
comma:	.asciiz ","
space:	.asciiz " "
newline:.asciiz "\n"

	.text
main:
# Print "Please enter a number: \n"
	la	$a0, msg
	li	$v0, 4
	syscall
# Get the seed from the user and store in seed
	li	$v0, 5
	syscall
	sw	$v0, seed

#--------------------------------------------------------------------------
#	
# Write your code here
main1:	jal	rand		#call to take the tresure_x
	add	$a2,$v0,$0	#$a2=treasure_x
	jal	rand		#call to take the treasure_y
	add	$a3,$v0,$0	#$a3=treasure_y
	addi	$t9,$0,9	#the value of range(limit)
	addi	$t7,$0,2	#use this when checkprint_x and checkprint_y
	addi	$t6,$0,1	#use this when checkprint_x and checkprint_y & continue
	addi	$s0,$0,4	#use this when checkprint_x and checkprint_y
# Print "What is the x coordinate of the treasure (0-9)? "
Get_x:	la	$a0, msg0
	li	$v0, 4
	syscall
# Get guess x
	li	$v0, 5
	syscall
	move	$t1,$v0 	#set $t1=guess_x
	
	slt	$t8,$t1,$0	#if(x<0)-> go to Wrong_x
	bne	$t8,$0,Wrong_x
	slt	$t8,$t9,$t1	#if(x>9)-> go to Wrong_x
	bne	$t8,$0,Wrong_x
	
# Print "What is the y coordinate of the treasure (0-9)? "
Get_y:	la	$a0, msg1
	li	$v0, 4
	syscall
# Get guess y
	li	$v0, 5
	syscall
	move	$t2,$v0 	#set $t2=guess_y
	
	slt	$t8,$t2,$0	#if(y<0)-> go to Wrong_y
	bne	$t8,$0,Wrong_y
	slt	$t8,$t9,$t2	#if(y>9)-> go to Wrong_y
	bne	$t8,$0,Wrong_y
	add	$a1,$0,$t2	#set $a1=guess_y
	add	$a0,$0,$t1	#set $a0=guess_x

	jal	Check_coordinate	#call to check guess_x and guess_y and compared to treasure_x,y
	add	$t3,$v0,$v1		#if(guess_x==treasure_x && guess_y==treasure_y)-> go to printequal
	bne	$t3,$s0,checkprint_x	#if not, go to checkprint_x
	j	printequal
checkprint_x:	
	bne	$v0,$t7,nequal_x	#if(guess_x==treasure_x)-> go to printequal_x =>not both x and y
	j	printequal_x		#if not, go to nequal_x
nequal_x:
	bne	$v0,$t6,nlarge_x	#if(guess_x<treasure_x)-> go to printsmall_x
	j	printsmall_x		#if not, go to nlarge
nlarge_x:
	j	printlarge_x		#guess_x>treasure_x=> go to printlarge_x

checkprint_y:				#the condition of printing the state of y
	bne	$v1,$t7,nequal_y	#if(guess_y==treasure_y)-> go to printequal_y =>not both x and y
	j	printequal_y		#if not, go to nequal_y
nequal_y:bne	$v1,$t6,nlarge_y	#if(guess_y<treasure_y)-> go to printsmall_y
	j	printsmall_y		#if not, go to nlarge
nlarge_y:
	j	printlarge_y		#guess_y>treasure_y=> go to printlarge_y
	
continue:
	jal	printcontinue		#check whether continue or not
	beq	$a1,$0,printbye		#$a1=0-> end the game
	beq	$a1,$t6,main1		#$a1=1-> continue the game
	jal	printwrong		#if($a1!=0 && $a1!=1)	print wrong message and then try continue
	j	continue
printbye:
	# Print "Play with me next time. See YOU!!\n"
	la	$a0, msg11	
	li	$v0, 4
	syscall	
#
#--------------------------------------------------------------------------

# Terminate the program
	li	$v0, 10
	syscall


#--------------------------------------------------------------------------
# function for determine the correctness of the coordinate
# Assume:
#	1. Guess x and y are stored in $a0, $a1 respectively
#	2. Treasure x and y are stored in $a2, $a3 respectively
# Outputs:
#	1. v0 (2: when treasure x = guess x, 1: treasure x > guess x, 0: treasure x < guess x)
#	2. v1 (2: when treasure y = guess y, 1: treasure y > guess y, 0: treasure y < guess y)
#
Check_coordinate:
#--------------------------------------------------------------------------
#
# Write your code here
	addi	$sp,$sp,-4	#allocate 1 word on the stack
	sw	$ra,0($sp)	#save $ra in stack framw
	jal	check_y		#check y coordinate first
	beq	$a0,$a2,equal_x	#if(treasure_x==guess_x)-> go to equal_x
	slt	$t5,$a0,$a2	#if(treasure_x>guess_x)-> go to small_x
	bne	$t5,$0,small_x	#else(treasure_x<guess_x)->$v0=0
	addi	$v0,$0,0
	lw	$ra,0($sp)	#restore $ra from stack frame
	addi	$sp,$sp,4	#dellocate 1 word on the stack
	jr	$ra		
	
small_x:addi	$v0,$0,1	#if(treasure_x>guess_x)-> $v0=1
	lw	$ra,0($sp)	#restore $ra from stack frame
	addi	$sp,$sp,4	#dellocate 1 word on the stack
	jr	$ra		

equal_x:addi	$v0,$0,2	#if(treasure_x==guess_x)-> $v0=2
	lw	$ra,0($sp)	#restore $ra from stack frame
	addi	$sp,$sp,4	#dellocate 1 word on the stack
	jr	$ra		
	
check_y:beq	$a1,$a3,equal_y	#if(treasure_y==guess_y)-> go to equal_y
	slt	$t5,$a1,$a3	#if(treasure_y>guess_y)-> go to small_y
	bne	$t5,$0,small_y	#else(treasure_y<guess_y)->$v1=0
	addi	$v1,$0,0
	jr	$ra		
small_y:addi	$v1,$0,1	#if(treasure_y>guess_y)-> $v1=1
	jr	$ra		
equal_y:addi	$v1,$0,2	#if(treasure_y==guess_y)-> $v1=2
#
#--------------------------------------------------------------------------
	jr	$ra		
#--------------------------------------------------------------------------


#--------------------------------------------------------------------------
#
# Write function(s) here (if any)
#Print "Out of Range!!\n" 
Wrong_x:la	$a0, msg12
	li	$v0, 4
	syscall	
	j	Get_x	#go back to Get_x
#Print "Out of Range!!\n" 	
Wrong_y:la	$a0, msg12
	li	$v0, 4
	syscall	
	j	Get_y	#go back to Get_y
printequal:
	# Print "You get the treasure!!! ("
	la	$a0, msg8
	li	$v0, 4
	syscall
	#Print x
	li	$v0,1		
	move	$a0,$t1
	syscall
	#Print ","
	la	$a0, comma
	li	$v0, 4
	syscall
	#Print y
	li	$v0,1		
	move	$a0,$t2
	syscall
	#Print ")\n"
	la	$a0,c_bkt 
	li	$v0, 4
	syscall
	j	continue	#go back to continue
printequal_x:

	# Print "The x coordinate of the treasure is correct. ("
	la	$a0, msg4
	li	$v0, 4
	syscall
	#Print x
	li	$v0,1		
	move	$a0,$t1
	syscall
	#Print ")\n"
	la	$a0,c_bkt 
	li	$v0, 4
	syscall
	j	checkprint_y	#go back to checkprint_y
	
printsmall_x:
	# Print "The x coordinate of the treasure is larger than your guess. ("
	la	$a0, msg2
	li	$v0, 4
	syscall
	#Print x
	li	$v0,1		
	move	$a0,$t1
	syscall
	#Print ")\n"
	la	$a0,c_bkt 
	li	$v0, 4
	syscall
	j	checkprint_y	#go back to checkprint_y
	
printlarge_x:
	# Print "The x coordinate of the treasure is smaller than your guess. ("
	la	$a0, msg3
	li	$v0, 4
	syscall
	#Print x
	li	$v0,1		
	move	$a0,$t1
	syscall
	#Print ")\n"
	la	$a0,c_bkt 
	li	$v0, 4
	syscall
	j	checkprint_y	#go back to checkprint_y
	
printequal_y:
	# Print "The y coordinate of the treasure is correct. ("
	la	$a0, msg7
	li	$v0, 4
	syscall
	#Print y
	li	$v0,1		
	move	$a0,$t2
	syscall
	#Print ")\n"
	la	$a0,c_bkt 
	li	$v0, 4
	syscall
	j	Get_x	#go back to Get_x
printsmall_y:
	# Print "The y coordinate of the treasure is larger than your guess. ("
	la	$a0, msg5
	li	$v0, 4
	syscall
	#Print y
	li	$v0,1		
	move	$a0,$t2
	syscall
	#Print ")\n"
	la	$a0,c_bkt 
	li	$v0, 4
	syscall
	j	Get_x	#go back to Get_x
printlarge_y:
	# Print "The y coordinate of the treasure is smaller than your guess. ("
	la	$a0, msg6
	li	$v0, 4
	syscall
	#Print y
	li	$v0,1		
	move	$a0,$t2
	syscall
	#Print ")\n"
	la	$a0,c_bkt 
	li	$v0, 4
	syscall
	j	Get_x	#go back to Get_x
printcontinue:
	# Print "Do you want to continue?? (0:No, stop the game.  1:Yes, play again.) "
	la	$a0, msg9
	li	$v0, 4
	syscall
	# Get the number whether continue or not
	li	$v0, 5
	syscall
	move	$a1,$v0
    	jr 	$ra	
printwrong:
	# Print "Wrong message! Please enter either (0) or (1)!!!!\n"
	la	$a0, msg10
	li	$v0, 4
	syscall
	jr	$ra	
#
#--------------------------------------------------------------------------



#--------------------------------------------------------------------------
# function for generating random number (0 - 9), return in $v0
rand:	addi	$sp, $sp, -8	# adjust the stack pointer
	sw	$t0, 4($sp)	# store registers' value to stack
	sw	$ra, 0($sp)
	addu	$t0, $t0, $ra
	jal	randnum
	addi	$t0, $0, c_range_xy
	remu	$v0, $v0, $t0	# get the reminder of division
	lw	$ra, 0($sp)	# load the values from the stack to registers
	lw	$t0, 4($sp)
	addi	$sp, $sp, 8
	jr	$ra
	
randnum:addi	$sp, $sp, -8	# adjust the stack pointer
	sw	$t0, 4($sp)	# store registers' value to stack
	sw	$t1, 0($sp)
	lw	$v0, seed
	addu	$v0, $v0, $t0
	addiu	$t0, $0, 13	# Load in first prime
	addiu	$t1, $0, 3147	# Load in the first mod value
	multu	$v0, $t0	# seed = seed * 13
	mflo	$v0		# Get the LO result of the multiply
	addiu	$v0, $v0, 14689	# seed = seed + 14689
	remu	$v0, $v0, $t1	# seed = seed % 3147
	sw	$v0, seed	# Save the new seed
	lw	$t1, 0($sp)	# load the values from the stack to registers
	lw	$t0, 4($sp)
	addi	$sp, $sp, 8
	jr	$ra
#------------------------------------------------------------------------------
