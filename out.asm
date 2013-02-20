.text
	 # se 1 < 10
	 addi $8, $0, 1
	 addi $9, $0, 10
	 bge $8, $9, lbl1

	 # mostre 3
	 addi $4, $0, 3
	 addi $2, $0, 1
	 syscall

	 # mostre 52
	 addi $4, $0, 52
	 addi $2, $0, 1
	 syscall
lbl1: