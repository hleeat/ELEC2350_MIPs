		.text
		j		pre
main:
# ---- Codes to focus in Lab2 ----
		add		$t3,$t2,$t0
		sub		$t0,$t2,$t0
		and		$a0,$t3,$t0
		or		$a1,$t3,$t0
		nor		$a2,$t3,$t0
		lw		$t6, 0($0)
		lw		$t7, 12($0)
		sw		$t6, 20($0)
		addi		$v0,$0,1
		slt		$at,$t6,$t7
		beq		$at,$0,1
		beq		$at,$v0,-1
		j		0x0d
# --------------------------------
pre:
		addi		$t0,$0,1
		addi		$t1,$0,2
		addi		$t2,$0,4
		addi		$t3,$0,8
		addi		$t4,$0,16
		addi		$t5,$0,32
		addi		$t6,$0,64
		addi		$t7,$0,128
		addi		$t8,$0,256
		addi		$t9,$0,512
		j		main
.data
		.word 0x0001
		.word 0x0002
		.word 0x0004
		.word 0x0008
		.word 0x0010
		.word 0x0020
		.word 0x0040
		.word 0x0080
		.word 0x0100
		.word 0x0200