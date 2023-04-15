.data

.align 2
numere_prime: .space 100

.text

	li $t4,0 #contorul de numere prime
	li $t5,24 #numarul total de numere prime
	li $a1,2 #numarul de verificat
	la $t6,numere_prime

cauta:
	jal functie_test_prim
	beqz $s0,nu_e_prim
	
e_prim:
	addi $t4,$t4,1
	sw $a1,($t6)
	addi $t6,$t6,4
	li $v0,1
	move $a0,$a1
	syscall
	putc ' '

nu_e_prim:
	addi $a1,$a1,1
	sge $t7,$t4,$t5
	bnez $t7,sfarsit
	j cauta

sfarsit:
	li $v0,10
	syscall
	
#primeste prezumtivul numar prim in $a1
#intoarce in $s0 1, daca numarul e prim, si 0 daca nu e prim
functie_test_prim:

	li $t0,1

repeta:
	addi $t0,$t0,1
	sge $t3,$t0,$a1 # $t3 = 1 daca $t0 >= $a1
	bnez $t3,gata_prim
	div $a1,$t0
	mfhi $t1
	mflo $t2
	beqz $t1,gata_neprim
	j repeta
	
gata_neprim:
	li $s0,0
	j iesire_proc

gata_prim:
	li $s0,1

iesire_proc:
	jr $ra #jump la  adresa de revenire
	