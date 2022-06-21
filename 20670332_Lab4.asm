.text
		# ---- Codes to focus in Lab 4 ----
		lw		$t2,0($0)
		lw		$t0,4($0)
		add		$a0,$t2,$t0
		sub		$a1,$t2,$a0
		addi		$a2,$t2,8
		add		$v0,$t2,$t0
		nop
		nop
		nop
		sub		$v1,$t2,$v0
		# --------------------------------
.data
		.word 0x4
		.word 0x5
		.word 0x5
