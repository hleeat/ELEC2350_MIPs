.text
		# ---- Codes to focus in Lab 3 ----
		lw		$a0,8($0)
		add		$t6,$0,$a0
		sw		$a0,0($0)
		sub		$t7,$0,$a0
		or		$a1,$t6,$t7
		nor		$a2,$t6,$t7
		and		$a3,$t6,$t7
		slt		$at,$t6,$t7
		beq		$at,$0,0
		j		0x09
		# --------------------------------
.data
		.word 0x3
		.word 0x3
		.word 0x2
