.data
n: 
.asciiz "\tIntroduceti numarul:"
Suma: 
.asciiz "\tSuma este:"
Produs: 
.asciiz "\t Produsul este: "
Negativ:
.asciiz "Ai tastat un numar negativ! Reincearca "

.text
main:la $a0, n
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	bltz $t0, eroare
	li $t2, 1
	li $t3, 0
	li $t4, 10
	li $t5, 5
loop:
	div $t0, $t4
	mfhi $t7 #restul
	mflo $t0 #catul
	ble $t7, $t5, suma #daca rest <=5 facem suma
produs:
	mul $t2, $t2, $t7
	bnez $t0,loop
	j afisare
suma: add $t3, $t3, $t7
	  bge $t7, $t5, produs #dara restul e si egal cu 5 facem si produsul
	  bnez $t0, loop
	  j afisare
	  
eroare:
	la $a0, Negativ
	li $v0, 4
	syscall
	j main
afisare:
	la $a0, Produs
	li $v0, 4
	syscall
	puti $t2
	la $a0, Suma
	li $v0, 4
	syscall
	puti $t3
	done
  