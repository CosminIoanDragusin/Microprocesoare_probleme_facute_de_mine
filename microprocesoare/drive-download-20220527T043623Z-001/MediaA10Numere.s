.data #0x1001000

suma: .space 4 #aloca n octeti de spatiu în segmentul curent.
cat: .space 4
rest: .space 4

endline: .asciiz "\n"
sumaEste: .asciiz "Suma este: "
catulEste: .asciiz "Catul este: "
restulEste: .asciiz "Restul este: "

#aliniaza datele urmatoare într-un domeniu de 2^n octeti. De exemplu, .align 2 aliniaza valorile
#urmatoare într-un domeniu limitat de 1 cuvânt (word).
.align 2
numere: .word 1,2,3,4,5,6,7,8,9,10

.text

	xor $t0,$t0,$t0
	li $t1, 9

loop:
	la $t4, numere
	li $t5, 4
	mul $t3,$t1,$t5 # $t3 = 4 * 10
	add $t5,$t4,$t3 # $t5 = numere + $t3
	lw $t2,($t5)
	add $t0,$t0,$t2 #suma
	addi $t1,$t1,-1
	bgez $t1,loop

	#afisarea etichetei de suma
	la $a0, sumaEste
	li $v0, 4 #4 pentru ca e ASCII - VEZI SOAC PAGINA 30 - TABEL
	syscall
	
	#afisarea valorii sumei
	sw $t0,suma
	move $a0,$t0
	li $v0, 1 #1 pentru ca e INT
	syscall
	
	#afisarea endline
	la $t4, endline
	lb $t4,($t4)
	move $a0,$t4
	li $v0, 11 #11 pentru ca e CHAR
	syscall
	
	#afisarea etichetei de cat
	la $a0, catulEste
	li $v0, 4
	syscall
	
	#calculare medie, cat si rest
	li $t1, 10
	div $t0,$t1 #LO = cat HI = rest
	
	#afisare cat
	mflo $t4
	sw $t4, cat
	move $a0,$t4
	li $v0,1
	syscall
	
	#afisarea endline
	la $t4, endline
	lb $t4,($t4)
	move $a0,$t4
	li $v0, 11
	syscall
	
	#afisarea etichetei de rest
	la $a0, restulEste
	li $v0,4
	syscall
	
	#afisare rest
	mfhi $t4
	sw $t4,rest
	move $a0,$t4
	li $v0,1
	syscall
	
	#sfarsit program
	li $v0,10
	syscall
	