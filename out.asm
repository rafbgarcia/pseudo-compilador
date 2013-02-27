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

	 # para 1 ate 10
lbl2:
	 addi $10, $0, 1
	 addi $11, $0, 10

	 # mostre 1
	 addi $4, $0, 1
	 addi $2, $0, 1
	 syscall

	 # Incremento
	 addi $10, $10, 1

	 # Enquanto for menor que $11, volta pra lbl2
	 blt $10, $11, lbl2