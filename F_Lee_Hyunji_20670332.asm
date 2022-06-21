# ELEC2350 (2020/21 Fall) - Introduction to Computer Organization and Design
# Final Project
# LEE, Hyunji (20670332)
		.data
result:	.space 4		# Store the sum of integers being loaded
size:	.word 1		# Controlling how many integers to be loaded
		.space 24
		.text

#@)^&)##@@)^&)##@@)^&)##@	Start Writing your Codes Below	@)^&)##@@)^&)##@@)^&)##@
		addi $t1,$0,96#define the start of the first address that I use in vertical line, array[7] that we start
		addi $s3,$0,1 #i=1	
		#la $s1,array
		lw $s0,size#load the size number
		lw $s2,result	#load the result number


if:		
		lw $t6,0($t1) #load the value that was in address 96 to $t6
		addi $t7,$0,96#define the start of the first address that I use in diagonal line, array[7] that we start
		la $s1,array#load array and define the the first register in array=68
		nop
		add $s2,$s2,$t6 #result=result+the value of the first number in rule (array[7])
		beq $s3,$s0,Final#if size==i then go to Final function and end the process
		
			
For:		
		addi $t7,$t7,32 #the rule in vertical line increase by 32 because it grows by 8 in array(8*4=32)
		addi $t1,$t1,28 #the rule in diagonal line increase by 28 because it grows by 7 in array(7*4=28)
		addi $s3,$s3,1 	#i++
		nop
		lw $s5,0($t7) #load the value in vertical line array to $s5
		lw $t6,0($t1) #load the value in diagonal line array to $t6
		nop
		nop
		add $s2,$s2,$s5 # result=result+the value in vertical line
		nop
		nop
		nop
		add $s2,$s2,$t6 #result=result+the value in diagonal line
		beq $s3,$s0,Final #if size==i then go to Final function and end the process
		nop
		nop
		nop
		beq $0,$0, For#if size!=i then go to For function and this is the loop
		
Final:	sw $s2,result #stoe the value of result in $s2



#@)^&)##@@)^&)##@@)^&)##@	End of your Codes				@)^&)##@@)^&)##@@)^&)##@

#@)^&)##@@)^&)##@@)^&)##@	The Array Containing 64 Integers	@)^&)##@@)^&)##@@)^&)##@
		.data
		.space 36
array:	.word 2
		.word 1
		.word 8
		.word 10
		.word 4
		.word 8
		.word 9
		.word 9
		.word -8
		.word -10
		.word -4
		.word -8
		.word -9
		.word -9
		.word -2
		.word -1
		.word 4
		.word 8
		.word 9
		.word 9
		.word 2
		.word 1
		.word 8
		.word 10
		.word -9
		.word -9
		.word -2
		.word -1
		.word -8
		.word -10
		.word -4
		.word -8
		.word 2
		.word 1
		.word 8
		.word 10
		.word 4
		.word 8
		.word 9
		.word 9
		.word -8
		.word -10
		.word -4
		.word -8
		.word -9
		.word -9
		.word -2
		.word -1
		.word 4
		.word 8
		.word 9
		.word 9
		.word 2
		.word 1
		.word 8
		.word 10
		.word -9
		.word -9
		.word -2
		.word -1
		.word -8
		.word -10
		.word -4
		.word -8
		
